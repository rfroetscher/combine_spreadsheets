class Spreadsheetdoc < ActiveRecord::Base
  has_and_belongs_to_many :projects
  mount_uploader :spreadsheetfile, SpreadsheetFileUploader
  belongs_to :user
  has_many :key_rows
  has_many :key_columns, through: :key_rows
  before_create :default_name
  validates_presence_of :spreadsheetfile
  

  def default_name
    self.name = File.basename(spreadsheetfile.filename, '.*').titleize if spreadsheetfile
  end

  def build_key_first_row
  	key_first_row = KeyRow.create(name: 'first', spreadsheetdoc: self)
  end

  def build_key_column(first_row_data, key_first_row)
  	first_row_data.each_with_index do |column, index|
  		 KeyColumn.create(key_row: key_first_row, name: column, originalorder: index, order: index)
  	end
  end

  def build_rows_and_columns
  	key_first_row = build_key_first_row
  	build_key_column(get_first_row_data, key_first_row)
  end

  def get_first_row_data
  	Roo::Spreadsheet.open(self.spreadsheetfile.url).row(1)
  end

end
