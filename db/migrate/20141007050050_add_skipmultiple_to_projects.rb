class AddSkipmultipleToProjects < ActiveRecord::Migration
  def change
  	add_column :projects, :skip_multiple, :boolean
  end
end
