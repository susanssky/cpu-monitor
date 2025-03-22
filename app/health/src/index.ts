import express, { Express } from 'express'
import cors from 'cors'
import 'dotenv/config'

import healthRoutes from './routes/health'

const app: Express = express()
app.use(cors())
app.use(express.json())

app.use('/health', healthRoutes)

app.listen(process.env.PORT, () => {
  console.log(`Server is listening on port ${process.env.PORT}`)
})
