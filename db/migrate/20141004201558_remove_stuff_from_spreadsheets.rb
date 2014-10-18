class RemoveStuffFromSpreadsheets < ActiveRecord::Migration
  def change
  	remove_column :spreadsheets, :spreadsheetfile_file_name
  	remove_column :spreadsheets, :spreadsheetfile_content_type
  	remove_column :spreadsheets, :spreadsheetfile_file_size
  	remove_column :spreadsheets, :spreadsheetfile_updated_at
  	remove_column :spreadsheets, :project_id
  	remove_column :projects, :combinationfile_file_name
  	remove_column :projects, :combinationfile_content_type
  	remove_column :projects, :combinationfile_file_size
  	remove_column :projects, :combinationfile_updated_at
  end
end
