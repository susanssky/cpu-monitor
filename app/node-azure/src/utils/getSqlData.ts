import { db } from '../db/db'
import { dbTable } from '../db/schema'

import { getNodeNamesAndCpu } from './getData'
import { DataType } from './types'

export const refreshNodes = async () => {
  try {
    const nodesData = await getNodeNamesAndCpu()
    console.log(`nodesData`)
    console.log(nodesData)

    const instances = nodesData.map(({ nodeId, cpuUsage }: DataType) => ({
      nodeId,
      cpu: cpuUsage,
    }))

    const results = await db
      .insert(dbTable)
      .values(instances)
      .onConflictDoUpdate({
        target: dbTable.nodeId,
        set: {
          cpu: dbTable.cpu,
        },
      })
      .returning()

    return results
  } catch (err) {
    console.error(err)
  }
}
