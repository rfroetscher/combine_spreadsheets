class SpreadsheetdocsController < ApplicationController
  before_action :authenticate_user!

  def new
    @spreadsheet = Spreadsheetdoc.new
  end

  def create
    @spreadsheet = Spreadsheetdoc.new(spreadsheet_params)
    @spreadsheet.user_id = current_user.id
    @spreadsheet.save!
    redirect_to spreadsheetdocs_path
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def index
    @spreadsheets = current_user.spreadsheetdocs
  end

  def show
  end
  private
  def spreadsheet_params
    params.require(:spreadsheetdoc).permit(:name, :spreadsheetfile)
  end

end
