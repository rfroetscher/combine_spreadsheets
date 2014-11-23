class ProjectsController < ApplicationController
  before_action :authenticate_user!
  require 'csv'
  require 'tempfile'

  def new
    @project = Project.new
    @spreadsheets = current_user.spreadsheetdocs
  end

  def create
    @project = Project.new
    @project.name = params[:name]
    @project.user = current_user
    @project.skip_multiple = params[:skip_multiple]
    params[:spreadsheet_ids].each do |e|
      @project.spreadsheetdocs << Spreadsheetdoc.find(e)
    end

    @project.spreadsheetdocs.each do |spreadsheet|
      if @project.first_row_doesnt_exist?(spreadsheet.id)
        columns = @project.get_first_row(spreadsheet.id)
        y = KeyRow.new
        y.name = "first"
        y.spreadsheetdoc = spreadsheet
        y.save!

        columns.each_with_index do |column, index|
          z = KeyColumn.new
          z.key_row_id = y.id
          z.name = column
          z.originalorder = index
          z.order = index
          z.save!
        end
      end
    end
    if @project.save!
      redirect_to reorder_projects_path(project_id: @project.id)
    end
  end

  def reorder
    @project = Project.find(params[:project_id])
  end

  def sort
    params[:key_column].each_with_index do |id, index|
      KeyColumn.where(id: id).update_all(order: index+1)
    end
    render nothing: true
  end

  def combine
    @project = Project.find(params[:project_id])
    @project.combinedfile = File.open(@project.combine_spreadsheets(@project.id))
    @project.save!
    redirect_to @project
  end

  def show
    @project = Project.find(params[:id])
  end

  def edit
    @project = Project.find(params[:id])
    @spreadsheets = current_user.spreadsheetdocs
  end

  def update
    @project = Project.find(params[:id])
    @project.name = params[:name]
    @project.user = current_user
    @project.skip_multiple = params[:skip_multiple]
    @project.spreadsheetdocs.clear
    params[:spreadsheet_ids].each do |e|
      @project.spreadsheetdocs << Spreadsheetdoc.find(e)
    end
  end

  def index
    @projects = current_user.projects
  end

  def destroy
  end
end
