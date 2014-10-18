class AddSpreadsheetFileToSpreadsheets < ActiveRecord::Migration
  def change
    add_column :spreadsheets, :spreadsheetfile, :string
  end
end
