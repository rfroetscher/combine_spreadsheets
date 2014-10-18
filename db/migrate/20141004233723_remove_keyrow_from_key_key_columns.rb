class RemoveKeyrowFromKeyKeyColumns < ActiveRecord::Migration
  def change
  	remove_column :key_columns, :keyrow_id
  	add_column :key_columns, :key_row_id, :integer
  end
end
