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
    if @project.save
      redirect_to reorder_projects_path(project_id: @project.id)
    else
      @spreadsheets = current_user.spreadsheetdocs
      flash[:alert] = "There was a problem saving your project:"
      @project.errors.full_messages.each do |error|
        flash[:alert] << " \u2022 #{error}"
      end
      render 'edit'
      flash[:alert] = nil
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
    @project.name = params[:project][:name]
    @project.user = current_user
    @project.skip_multiple = params[:skip_multiple]
    @project.spreadsheetdocs.clear
    params[:spreadsheet_ids].each do |e|
      @project.spreadsheetdocs << Spreadsheetdoc.find(e)
    end
    if @project.save
      redirect_to projects_path
    else
      flash[:alert] = "There was a problem saving your project:"
      @project.errors.full_messages.each do |error|
        flash[:alert] << " \u2022 #{error}"
      end
      render 'edit'
      flash[:alert] = nil
    end
  end

  def index
    @projects = current_user.projects
  end

  def destroy
    Project.delete(params[:id])
    flash[:notice] = "Project successfully deleted!"
    redirect_to projects_path
  end
end
