class Calendar < ApplicationRecord
  has_many :goals
  has_many :notes
end
