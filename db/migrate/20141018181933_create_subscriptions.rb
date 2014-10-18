class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.references :user, index: true
      t.date :active_until
      t.boolean :active
      t.boolean :recurring
      t.string :product_name

      t.timestamps
    end
  end
end
