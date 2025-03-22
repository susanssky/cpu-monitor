import express from 'express'
import {
  getNodefromDb,
  callSdkToGetNodeAgain,
  updateNodeBookmarked,
} from '../controllers/node'

const router = express.Router()

router
  .route('/')
  .get(getNodefromDb)
  .post(callSdkToGetNodeAgain)
  .patch(updateNodeBookmarked)

export default router
