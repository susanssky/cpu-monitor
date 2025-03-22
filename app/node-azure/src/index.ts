import express, { Express, Request, Response } from 'express'
import cors from 'cors'
import 'dotenv/config'

import nodeRoutes from './routers/node'

import { refreshNodes } from './utils/getSqlData'

const app: Express = express()
app.use(cors())
app.use(express.json())

async function runSeeding() {
  try {
    await getLatestNodes()
    console.log('Seeding Completed!')
  } catch (err) {
    console.error('Error during seeding:', err)
  }
}

runSeeding()

app.use('/node', nodeRoutes)

app.listen(process.env.PORT, () => {
  console.log(`tenant id: ${process.env.TENANT_ID}`)
  console.log(`client id: ${process.env.CLIENT_ID}`)
  console.log(`client secret: ${process.env.CLIENT_SECRET}`)
  console.log(`subscription id: ${process.env.SUBSCRIPTION_ID}`)
  console.log(`resource group name: ${process.env.RESOURCE_GROUP_NAME}`)
  console.log(`cluster name: ${process.env.CLUSTER_NAME}`)
  console.log('Database URL:', process.env.DATABASE_URL)
  console.log(`Server is listening on port ${process.env.PORT}`)
})

export async function getLatestNodes() {
  await refreshNodes()
}
