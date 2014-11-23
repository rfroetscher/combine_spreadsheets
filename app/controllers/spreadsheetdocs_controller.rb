class SpreadsheetdocsController < ApplicationController
  before_action :authenticate_user!

  def new
    @spreadsheet = Spreadsheetdoc.new
  end

  def create
    @spreadsheet = Spreadsheetdoc.new(spreadsheet_params)
    @spreadsheet.user_id = current_user.id
    if @spreadsheet.save
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
