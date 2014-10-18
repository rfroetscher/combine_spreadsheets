class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.integer :price
      t.string :name
      t.integer :length

      t.timestamps
    end
  end
end
