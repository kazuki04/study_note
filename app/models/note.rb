class Note < ApplicationRecord

  with_options presence: true do
    validates :highlight
    validates :excerpt
    validates :body
    validates :written_day
  end

  belongs_to :user
  belongs_to :calendar
end
