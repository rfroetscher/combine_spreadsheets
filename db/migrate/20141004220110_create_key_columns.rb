class CreateKeyColumns < ActiveRecord::Migration
  def change
    create_table :key_columns do |t|
      t.string :name
      t.references :keyrow, index: true

      t.timestamps
    end
  end
end
