class Goal < ApplicationRecord
  belongs_to :calendar
  validates :goal_name, presence: true
end
