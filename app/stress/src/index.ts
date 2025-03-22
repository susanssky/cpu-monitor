import express, { Express } from 'express'
import cors from 'cors'
import 'dotenv/config'

import stressRoutes from './routes/stress'

const app: Express = express()
app.use(cors())
app.use(express.json())

app.use('/stress', stressRoutes)

app.listen(process.env.PORT, () => {
  console.log(`Server is listening on port ${process.env.PORT}`)
})
