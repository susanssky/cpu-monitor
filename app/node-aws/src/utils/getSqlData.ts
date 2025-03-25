// import { client } from '../server'
import { getInstanceInfoByAsgName } from './getEc2InstancesInfo'

import { getAutoScalingGroupName } from './getAutoScalingGroupName'
import { db } from '../db/db'
import { dbTable } from '../db/schema'

export const refreshInstances = async () => {
  try {
    const asgName = await getAutoScalingGroupName()
    const ec2Data = await getInstanceInfoByAsgName(asgName)
    // console.log(`ec2Data`)
    // console.log(ec2Data)

    const instances = ec2Data!
      .filter(({ PrivateDnsName }) => PrivateDnsName !== '')
      .map(({ InstanceId, PrivateDnsName, cpu }) => ({
        instanceId: InstanceId!,
        nodeName: PrivateDnsName!,
        cpu: cpu!,
      }))

    if (instances.length === 0) {
      return []
    }

    const results = await db
      .insert(dbTable)
      .values(instances)
      .onConflictDoUpdate({
        target: dbTable.instanceId,
        set: {
          nodeName: dbTable.nodeName,
          cpu: dbTable.cpu,
        },
      })
      .returning()

    return results
  } catch (err) {
    console.error(err)
  }
}
