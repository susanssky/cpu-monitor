import { Table } from '@radix-ui/themes'
export default function DataTableHead() {
  return (
    <Table.Header>
      <Table.Row>
        <Table.ColumnHeaderCell justify='center'>
          isBookmarked
        </Table.ColumnHeaderCell>
        <Table.ColumnHeaderCell justify='center'>
          Node name
        </Table.ColumnHeaderCell>
        <Table.ColumnHeaderCell justify='center'>EC2 Id</Table.ColumnHeaderCell>
        <Table.ColumnHeaderCell justify='center'>CPU</Table.ColumnHeaderCell>
      </Table.Row>
    </Table.Header>
  )
}
