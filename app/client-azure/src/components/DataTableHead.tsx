import { Table } from '@radix-ui/themes'
export default function DataTableHead() {
  return (
    <Table.Header>
      <Table.Row>
        <Table.ColumnHeaderCell justify='center'>
          isBookmarked
        </Table.ColumnHeaderCell>
        <Table.ColumnHeaderCell justify='center'>
          Node Id
        </Table.ColumnHeaderCell>
        <Table.ColumnHeaderCell justify='center'>CPU</Table.ColumnHeaderCell>
      </Table.Row>
    </Table.Header>
  )
}
