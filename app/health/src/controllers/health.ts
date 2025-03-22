import { Request, Response } from 'express'

export const getHealth = async (req: Request, res: Response) => {
  return res.status(200).json({ status: 'health' })
}
