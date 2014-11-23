class Spreadsheetdoc < ActiveRecord::Base
  has_and_belongs_to_many :projects
  mount_uploader :spreadsheetfile, SpreadsheetFileUploader
  belongs_to :user
  has_many :key_rows
  has_many :key_columns, through: :key_rows
  validates :name, presence: true
  validates_presence_of :spreadsheetfile
end
