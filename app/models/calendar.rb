# frozen_string_literal: true

class Calendar < ApplicationRecord
  has_many :goals
  has_many :notes
end
