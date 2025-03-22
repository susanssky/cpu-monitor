import express, { Express, Request, Response } from 'express'
import cors from 'cors'
import 'dotenv/config'

import currentRoutes from './routes/current'

const app: Express = express()
app.use(cors())
app.use(express.json())

app.use('/current', currentRoutes)

app.listen(process.env.PORT, () => {
  console.log(`Server is listening on port ${process.env.PORT}`)
})
