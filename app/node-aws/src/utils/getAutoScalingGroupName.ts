import { EKSClient, DescribeNodegroupCommand } from '@aws-sdk/client-eks'

const region = 'eu-west-2'
const eksClient = new EKSClient({ region })

export async function getAutoScalingGroupName() {
  try {

    const eksCommand = new DescribeNodegroupCommand({
      clusterName: process.env.CLUSTER_NAME!,
      nodegroupName: process.env.NODE_GROUP_NAME!,
    })
    const nodegroupData = await eksClient.send(eksCommand)
    // console.log(`-----------`)
    // console.log(`nodegroupData`)
    // console.log(nodegroupData)

    const autoScalingGroups =
      nodegroupData.nodegroup?.resources?.autoScalingGroups
    if (!autoScalingGroups || autoScalingGroups.length === 0) {
      throw new Error('No Auto Scaling Groups found for the nodegroup')
    }
    const asgName = autoScalingGroups[0].name
    if (!asgName) {
      throw new Error('Auto Scaling Group name is undefined')
    }
    console.log('Auto Scaling Group Name:', asgName)

    return asgName
  } catch (error) {
    console.error('Error:', (error as Error).message)
    throw error
  }
}
