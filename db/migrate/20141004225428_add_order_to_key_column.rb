class AddOrderToKeyColumn < ActiveRecord::Migration
  def change
  	add_column :key_columns, :order, :integer
  end
end
