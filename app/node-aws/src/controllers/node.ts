import { Request, Response } from 'express'
import { refreshInstances } from '../utils/getSqlData'
import { db } from '../db/db'
import { dbTable } from '../db/schema'
import { eq } from 'drizzle-orm'


export const getEc2fromDb = async (req: Request, res: Response) => {
  try {
    const data = await db.select().from(dbTable)
    console.log(`data: ${JSON.stringify(data)}`)
    return res.status(200).json(data)
  } catch (err) {
    console.log(err)
    return res.status(500).json({ error: 'An error occurred' })
  }
}
export const callSdkToGetEc2Again = async (req: Request, res: Response) => {
  try {
    await db.delete(dbTable)

    const response = await refreshInstances()
    // console.log(`data: ${JSON.stringify(data)}`)
    return res.status(200).json(response)
    // return res.status(200).json(data)
  } catch (err) {
    console.log(err)
    return res.status(500).json({ error: 'An error occurred' })
  }
}
export const updateEc2Bookmarked = async (req: Request, res: Response) => {
  try {
    const { instance_id, is_bookmarked } = req.body
    if (!instance_id || is_bookmarked === undefined) {
      return res.status(400).json({ error: 'Invalid input' })
    }

    await checkExistById(instance_id)

    const updatedRow = await db
      .update(dbTable)
      .set({ isBookmarked: is_bookmarked })
      .where(eq(dbTable.instanceId, instance_id))
      .returning()


    return res.status(200).json(updatedRow[0])
  } catch (err) {
    console.log(err)
    return res.status(400).json({ error: 'An error occurred' })
  }
}
async function checkExistById(instanceId: string) {
  const result = await db
    .select()
    .from(dbTable)
    .where(eq(dbTable.instanceId, instanceId))

  if (result.length === 0) {
    throw new Error(`instanceId does not exist.`)
  }

  return result[0].instanceId
}
