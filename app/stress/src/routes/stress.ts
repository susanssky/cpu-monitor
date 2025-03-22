import express from 'express'
import { cpuStress } from '../controllers/stress'

const router = express.Router()

router.route('/').post(cpuStress)

export default router
