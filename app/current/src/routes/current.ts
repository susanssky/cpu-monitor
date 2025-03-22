import express from 'express'
import { getCurrentPodName } from '../controllers/current'

const router = express.Router()

router.route('/').get(getCurrentPodName)

export default router
