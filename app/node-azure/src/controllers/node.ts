import { Request, Response } from 'express'
import { refreshNodes } from '../utils/getSqlData'
import { db } from '../db/db'
import { dbTable } from '../db/schema'
import { eq } from 'drizzle-orm'

export const getNodefromDb = async (req: Request, res: Response) => {
  try {
    const data = await db.select().from(dbTable)
    console.log(`data: ${JSON.stringify(data)}`)
    return res.status(200).json(data)
  } catch (err) {
    console.log(err)
    return res.status(500).json({ error: 'An error occurred' })
  }
}
export const callSdkToGetNodeAgain = async (req: Request, res: Response) => {
  try {
    await db.delete(dbTable)

    const response = await refreshNodes()
    // console.log(`data: ${JSON.stringify(data)}`)
    return res.status(200).json(response)
    // return res.status(200).json(data)
  } catch (err) {
    console.log(err)
    return res.status(500).json({ error: 'An error occurred' })
  }
}
export const updateNodeBookmarked = async (req: Request, res: Response) => {
  try {
    const { node_id, is_bookmarked } = req.body
    if (!node_id || is_bookmarked === undefined) {
      return res.status(400).json({ error: 'Invalid input' })
    }

    await checkExistById(node_id)

    const updatedRow = await db
      .update(dbTable)
      .set({ isBookmarked: is_bookmarked })
      .where(eq(dbTable.nodeId, node_id))
      .returning()

    return res.status(200).json(updatedRow[0])
  } catch (err) {
    console.log(err)
    return res.status(400).json({ error: 'An error occurred' })
  }
}
async function checkExistById(node_id: string) {
  const result = await db
    .select()
    .from(dbTable)
    .where(eq(dbTable.nodeId, node_id))

  if (result.length === 0) {
    throw new Error(`nodeId does not exist.`)
  }

  return result[0].nodeId
}
