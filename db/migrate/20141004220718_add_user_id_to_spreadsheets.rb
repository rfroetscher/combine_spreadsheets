class AddUserIdToSpreadsheets < ActiveRecord::Migration
  def change
  	add_column :spreadsheets, :user_id, :integer
  	add_index :spreadsheets, :user_id, :name => 'user_id_ix'
  end
end
