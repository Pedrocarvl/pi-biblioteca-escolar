module SearchField
  extend ActiveSupport::Concern

  included do
    scope :search_all_fields, ->(text, columns) {
      columns = columns.compact_blank
      safe_columns = columns.map do |column|
        table_name, column_name = column.split('.')
        "#{connection.quote_table_name(table_name)}.#{connection.quote_column_name(column_name)}"
      end
      sanitized_sql = sanitize_sql_for_conditions(["CONCAT_WS(' ', #{safe_columns.join(', ')}) ILIKE ?", "%#{text}%"])
      where(sanitized_sql)
    }
  end
end
