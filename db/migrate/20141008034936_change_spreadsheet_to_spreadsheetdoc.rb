class ChangeSpreadsheetToSpreadsheetdoc < ActiveRecord::Migration
  def change
  	rename_column :key_rows, :spreadsheet_id, :spreadsheetdoc_id
  	rename_column :projects_spreadsheets, :spreadsheet_id, :spreadsheetdoc_id
  	rename_table :projects_spreadsheets, :projects_spreadsheetdocs
  	rename_table :spreadsheets, :spreadsheetdocs
  end
end
