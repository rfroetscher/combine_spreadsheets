class Project < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :spreadsheetdocs
  has_many :key_rows, through: :spreadsheetdocs
  mount_uploader :combinedfile, CombinedfileUploader
  validates :name, presence: true
  validate :has_more_than_one_spreadsheetdoc

  def has_more_than_one_spreadsheetdoc
    if self.spreadsheetdocs.length < 2
      errors.add(:base, "You must add more than one spreadsheet")
    end
  end

  def get_spreadsheet(id)
    spreadsheet = Spreadsheetdoc.find(id)
    @spreadsheet_object = Roo::Spreadsheet.open(spreadsheet.spreadsheetfile.url)
  end

  def upload_project_spreadsheet(project_id)
    project = Project.find(project_id)
  end

  def combine_spreadsheets(project_id)
    combined_table = reorder_spreadsheet_columns(project_id)
    temp_file = Tempfile.new(['combinedspreadsheet', '.csv'])
    CSV.open(temp_file, 'w') do |csv|
        combined_table.each do |row|
            csv << row
        end
    end
    temp_file
  end

  def reorder_spreadsheet_columns(project_id)
    project = Project.find(project_id)
    spreadsheets = project.spreadsheetdocs
    combined_table = []
    spreadsheets.each_with_index do |spreadsheet, index|
      old_file = Roo::Spreadsheet.open(spreadsheet.spreadsheetfile.url)
      table = []
      spreadsheet_index = index
      kc = spreadsheet.key_columns.sort_by {|kc| kc.order }
      kc.each_with_index do |key_column, index|
        table << old_file.column(key_column.originalorder+1)
      end
      newtable = table.transpose
      if spreadsheet_index != 0 && project.skip_multiple
        newtable.each_with_index do |row, i|
          combined_table << row unless i == 0
        end
      else
        newtable.each do |row|
          combined_table << row
        end
      end
    end
    combined_table
  end

end
