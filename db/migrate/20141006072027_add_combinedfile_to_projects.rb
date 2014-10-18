class AddCombinedfileToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :combinedfile, :string
  end
end
