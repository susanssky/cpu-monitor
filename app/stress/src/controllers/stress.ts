import { Request, Response } from 'express'

export async function cpuStress(req: Request, res: Response) {
  const msg = await stress()

  res.status(200).json({ message: msg })
}

async function stress() {
  // blocking stress test
  // const end = Date.now() + durationInSeconds * 1000
  // while (Date.now() < end) {
  //   Math.pow(Math.random() * 1000, Math.random() * 1000)
  // }
  // Non-blocking stress test
  const durationInSeconds = 300
  const start = Date.now()
  const durationMs = durationInSeconds * 1000
  return new Promise((resolve) => {
    const interval = setInterval(() => {
      for (let i = 0; i < 1e6; i++) {
        Math.pow(Math.random() * 100, Math.random() * 100)
      }
      if (Date.now() - start >= durationMs) {
        clearInterval(interval)
        resolve('Stress test completed')
      }
    }, 10) // Execute every 10ms to avoid complete blocking
  })
}
