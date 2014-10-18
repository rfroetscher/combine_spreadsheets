class CreateProjectsSpreadsheetsJoin < ActiveRecord::Migration
  def change
    create_join_table :spreadsheets, :projects do |t|
      t.index :spreadsheet_id
      t.index :project_id
    end
  end
end
