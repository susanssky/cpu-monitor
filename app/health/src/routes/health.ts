import express from 'express'
import { getHealth } from '../controllers/health'

const router = express.Router()

router.route('/').get(getHealth)

export default router
