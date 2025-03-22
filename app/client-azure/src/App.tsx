import './App.css'
import DataTable from './components/DataTable'
import { useState, useEffect } from 'react'
import { Button } from '@radix-ui/themes'

function App() {
  const [data, setData] = useState<DataType[]>([])
  const [currentPosition, setCurrentPosition] = useState<string>('')

  useEffect(() => {
    const fetchData = async (): Promise<void> => {
      try {
        const response = await fetch(
          `${import.meta.env.VITE_EXTERNAL_URL}/node`
        )
        if (!response.ok) throw Error('Did not receive expected data')
        const data = await response.json()
        console.log(`fetch /node`)
        console.log(data)
        setData(data)
      } catch (error) {
        console.log(error)
      }
    }
    fetchData()
  }, [])
  useEffect(() => {
    const fetchData = async (): Promise<void> => {
      try {
        const response = await fetch(
          `${import.meta.env.VITE_EXTERNAL_URL}/current`
        )
        if (!response.ok) throw Error('Did not receive expected data')
        const data = await response.json()
        console.log(`fetch /current`)
        console.log(data)
        setCurrentPosition(data)
      } catch (error) {
        console.log(error)
      }
    }
    fetchData()
  }, [])

  const handleRefresh = async () => {
    const response = await fetch(`${import.meta.env.VITE_EXTERNAL_URL}/node`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
    })
    console.log(`>>>handleRefresh`)
    const data = await response.json()
    console.log(data)
    setData(data)
  }
  const handleStress = async () => {
    const res = await fetch(`${import.meta.env.VITE_EXTERNAL_URL}/stress`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
    })
    const data = await res.json()
    console.log(`stress msg`)
    console.log(data)
  }
  return (
    <>
      <div>
        <h1>Node CPU Monitor</h1>
        <Button color='indigo' onClick={handleRefresh}>
          refresh
        </Button>{' '}
        <Button color='crimson' variant='soft' onClick={() => handleStress()}>
          Stress Test Request
        </Button>
        <p>{currentPosition && `You are in ${currentPosition}`}</p>
        <DataTable data={data} />
      </div>
    </>
  )
}

export default App
