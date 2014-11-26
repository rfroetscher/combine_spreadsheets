class SpreadsheetdocsController < ApplicationController
  before_action :authenticate_user!

  def new
    @spreadsheet = Spreadsheetdoc.new
  end

  def create
    @spreadsheet = Spreadsheetdoc.new(spreadsheet_params)
    @spreadsheet.user_id = current_user.id
    if @spreadsheet.save
      @spreadsheet.build_rows_and_columns
      redirect_to spreadsheetdocs_path
    else
      flash[:alert] = "There was a problem saving your spreadsheet:"
      @spreadsheet.errors.full_messages.each do |error|
      flash[:alert] << " \u2022 #{error}"
      end
      render 'edit'
      flash[:alert] = nil
    end
  end

  def destroy
    spreadsheet = Spreadsheetdoc.find(params[:id])
    if !spreadsheet.projects.empty?
      flash[:alert] = "Cannot delete a spreadsheet used in a project. Please remove the spreadsheet from project \"#{spreadsheet.projects.first.name}\"."
      redirect_to spreadsheetdocs_path
    else
      Spreadsheetdoc.destroy(params[:id])
      flash[:notice] = "Spreadsheet successfully deleted!"
      redirect_to spreadsheetdocs_path
    end
  end

  def index
    @spreadsheets = current_user.spreadsheetdocs
  end

  private

  def spreadsheet_params
    params.require(:spreadsheetdoc).permit(:name, :spreadsheetfile)
  end

end
