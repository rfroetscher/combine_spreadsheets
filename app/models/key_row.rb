class KeyRow < ActiveRecord::Base
  belongs_to :spreadsheetdoc
  has_many :key_columns
end
