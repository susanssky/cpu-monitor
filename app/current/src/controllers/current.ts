import { Request, Response } from 'express'
import os from 'os'

export const getCurrentPodName = async (req: Request, res: Response) => {
  try {
    const podName = os.hostname()
    console.log(`podName:${podName}`)

    return res.status(200).json(podName)
  } catch (error) {
    console.log(error)
  }
}
