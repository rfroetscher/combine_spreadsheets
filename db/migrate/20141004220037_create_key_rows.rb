class CreateKeyRows < ActiveRecord::Migration
  def change
    create_table :key_rows do |t|
      t.string :name
      t.references :spreadsheet, index: true

      t.timestamps
    end
  end
end
