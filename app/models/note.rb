class Note < ApplicationRecord
  belongs_to :user
  belongs_to :calendar
  has_many :note_tags
  has_many :tags, through: :note_tags
end
