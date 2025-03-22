import { Table } from '@radix-ui/themes'
import { useState, useEffect } from 'react'

export default function DataTableBody({ data }: DataTableBodyProps) {
  const [instances, setInstances] = useState<DataType[]>(data)

  useEffect(() => {
    setInstances(data)
    console.log(`data`)
    console.log(data)
  }, [data])

  const handleCheckBox = (nodeId: string) => {
    setInstances((prevState) =>
      prevState.map((instance) =>
        instance.nodeId === nodeId
          ? { ...instance, is_bookmarked: !instance.isBookmarked }
          : instance
      )
    )

    fetch(`${import.meta.env.VITE_EXTERNAL_URL}/node`, {
      method: 'PATCH',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        instance_id: nodeId,
        is_bookmarked: !data.find((item) => item.nodeId === nodeId)
          ?.isBookmarked,
      }),
    })
  }

  const formatCpu = (cpu: string) => {
    const cpuNumber = parseFloat(cpu)

    // Check if cpuNumber is a valid number
    if (isNaN(cpuNumber)) return cpu

    // Format the number with a percentage symbol
    return `${cpuNumber.toFixed(2)}%`
  }
  return (
    <>
      {instances.map((instance) => (
        <Table.Row key={instance.nodeId}>
          <Table.Cell justify='center'>
            <input
              type='checkbox'
              id='horns'
              name='horns'
              defaultChecked={instance.isBookmarked}
              onChange={() => handleCheckBox(instance.nodeId)}
            />
          </Table.Cell>
          <Table.RowHeaderCell justify='center'>
            {instance.nodeId}
          </Table.RowHeaderCell>

          <Table.Cell justify='center'>{formatCpu(instance.cpu)}</Table.Cell>
        </Table.Row>
      ))}
    </>
  )
}
