// ==========SDK
import { MonitorClient } from '@azure/arm-monitor'
import { ClientSecretCredential } from '@azure/identity'
import { DataType } from './types'

const subscriptionId = process.env.SUBSCRIPTION_ID!
const resourceGroupName = process.env.RESOURCE_GROUP_NAME!
const clusterName = process.env.CLUSTER_NAME!
const tenantId = process.env.TENANT_ID!
const clientId = process.env.CLIENT_ID!
const clientSecret = process.env.CLIENT_SECRET!

export async function getNodeNamesAndCpu() {
  try {
    // Create credential
    const credential = new ClientSecretCredential(
      tenantId,
      clientId,
      clientSecret
    )

    // Create Monitor client
    const monitorClient = new MonitorClient(credential, subscriptionId)

    // Set time range (last 30 minutes)
    const now = new Date()
    const start = new Date(now.getTime() - 30 * 60 * 1000)
    const end = now

    // Define resource URI
    const resourceUri = `/subscriptions/${subscriptionId}/resourceGroups/${resourceGroupName}/providers/Microsoft.ContainerService/managedClusters/${clusterName}`

    // Query metrics
    const metricsResponse = await monitorClient.metrics.list(resourceUri, {
      timespan: `${start.toISOString()}/${end.toISOString()}`,
      interval: 'PT1M',
      metricnames: 'node_cpu_usage_percentage',
      aggregation: 'Average',
      metricnamespace: 'microsoft.containerservice/managedclusters',
      filter: "node eq '*'",
    })

    // console.log(`metricsResponse.value[0].timeseries`)
    // console.log(JSON.stringify(metricsResponse.value[0].timeseries))

    // Process the response
    const allNodeData =
      metricsResponse.value[0].timeseries?.map((ts: any) => {
        // Fix: Use metadatavalues (lowercase v) and correct property access
        const nodeId = ts.metadatavalues?.find(
          (m: any) => m.name.value === 'node'
        )?.value

        const latestCpu = ts.data?.[ts.data.length - 1]?.average
        return { nodeId, cpuUsage: latestCpu }
      }) || []

    // console.log(`allNodeData`)
    // console.log(allNodeData)

    // Filter out undefined CPU usage values
    const validNodeData = allNodeData.filter(
      (data: DataType) => data.cpuUsage !== undefined
    )

    return validNodeData
  } catch (error) {
    console.error('Error:', error)
    throw error
  }
}
// ==========REST API
// import { ClientSecretCredential } from '@azure/identity'
// import axios from 'axios'
// import { DataType } from './types'

// const subscriptionId = process.env.SUBSCRIPTION_ID!
// const resourceGroupName = process.env.RESOURCE_GROUP_NAME!
// const clusterName = process.env.CLUSTER_NAME!
// const tenantId = process.env.TENANT_ID!
// const clientId = process.env.CLIENT_ID!
// const clientSecret = process.env.CLIENT_SECRET!

// export async function getNodeNamesAndCpu() {
//   const scope = 'https://management.azure.com/.default'
//   const credential = new ClientSecretCredential(
//     tenantId,
//     clientId,
//     clientSecret
//   )
//   const token = (await credential.getToken(scope)).token

//   const now = new Date()
//   // const start = new Date(now.getTime() - 24 * 60 * 60 * 1000).toISOString()
//   const start = new Date(now.getTime() - 30 * 60 * 1000).toISOString()
//   const end = now.toISOString()
//   const timespan = `${start}/${end}`
//   const interval = 'PT5M' // every 5 mins
//   const metricNamespace = 'microsoft.containerservice/managedclusters'
//   const metricNames = 'node_cpu_usage_percentage'
//   const aggregation = 'Average'
//   const filter = "node eq '*'"
//   const url = `https://management.azure.com/subscriptions/${subscriptionId}/resourceGroups/${resourceGroupName}/providers/Microsoft.ContainerService/managedClusters/${clusterName}/providers/microsoft.insights/metrics?timespan=${timespan}&interval=${interval}&metricnamespace=${metricNamespace}&metricnames=${metricNames}&aggregation=${aggregation}&api-version=2018-01-01&$filter=${encodeURIComponent(
//     filter
//   )}`
//   const headers = { Authorization: `Bearer ${token}` }

//   try {
//     const response = await axios.get(url, { headers })
//     // console.log(`res`)
//     // console.log(JSON.stringify(response.data.value[0].timeseries))
//     const timeseries = response.data.value[0].timeseries

//     const allNodeData = timeseries.map((ts: any) => {
//       const nodeId = ts.metadatavalues.find(
//         (m: any) => m.name.value === 'node'
//       ).value
//       const latestCpu = ts.data[ts.data.length - 1].average
//       return { nodeId, cpuUsage: latestCpu }
//     })

//     const validNodeData = allNodeData.filter(
//       (data: DataType) => data.cpuUsage !== undefined
//     )

//     // console.log('Node Names and CPU Usage:')
//     // validNodeData.forEach((data) => {
//     //   console.log(`Node: ${data.nodeId}, CPU Usage: ${data.cpuUsage}%`)
//     // })
//     return validNodeData
//   } catch (error: any) {
//     console.error('Error:', error.response?.data || error.message)
//   }
// }
