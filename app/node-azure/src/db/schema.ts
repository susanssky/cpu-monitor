import { pgTable, boolean, text, varchar } from 'drizzle-orm/pg-core'

export const dbTable = pgTable('nodes_status', {
  nodeId: varchar('node_id', { length: 50 }).primaryKey(),
  cpu: text('cpu'),
  isBookmarked: boolean('is_bookmarked').default(false),
})
