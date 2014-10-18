class ProjectStepsController < ApplicationController
	include Wicked::Wizard
	steps :reorder, :confirm
	skip_before_filter :verify_authenticity_token, :only => [:sort]	

	def show
		@project = Project.find(params[:project_id])
		render_wizard
	end

	def sort
		params[:key_column].each_with_index do |id, index|
		  KeyColumn.where(id: id).update_all(order: index+1)
		end
		render nothing: true
	end

	def update
		@project = Project.find(params[:project_id])
		render_wizard @project
	end
end
