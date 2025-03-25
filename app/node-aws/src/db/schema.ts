import { pgTable, boolean, text, varchar } from 'drizzle-orm/pg-core'

export const dbTable = pgTable('nodes_status', {
  instanceId: varchar('instance_id', { length: 50 }).primaryKey(),
  nodeName: varchar('node_name', { length: 50 }).notNull(),
  cpu: text('cpu'),
  isBookmarked: boolean('is_bookmarked').default(false),
})
