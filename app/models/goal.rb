# frozen_string_literal: true

class Goal < ApplicationRecord
  belongs_to :calendar
  belongs_to :user
  validates :goal_name, presence: true
end
