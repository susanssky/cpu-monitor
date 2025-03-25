import express, { Express, Request, Response } from 'express'
import cors from 'cors'
import 'dotenv/config'

import { default as ec2Routes } from './routers/node'
import { refreshInstances } from './utils/getSqlData'

const app: Express = express()
app.use(cors())
app.use(express.json())

async function runSeeding() {
  try {
    // await client.connect()
    await getLatestInstances()
    console.log('Seeding Completed!')
  } catch (err) {
    console.error('Error during seeding:', err)
  }
}

runSeeding()

app.use('/node', ec2Routes)

app.listen(process.env.PORT, () => {
  console.log('Database URL:', process.env.DATABASE_URL)
  console.log(`Server is listening on port ${process.env.PORT}`)
})

export async function getLatestInstances() {
  await refreshInstances()
}
