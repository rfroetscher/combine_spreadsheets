class AddOriginalorderToKeycolumns < ActiveRecord::Migration
  def change
  	add_column :key_columns, :originalorder, :integer
  end
end
