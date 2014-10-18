class CreateSpreadsheets < ActiveRecord::Migration
  def change
    create_table :spreadsheets do |t|
      t.string :name
      t.references :project, index: true

      t.timestamps
    end
  end
end
