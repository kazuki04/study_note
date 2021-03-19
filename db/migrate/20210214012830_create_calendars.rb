# frozen_string_literal: true

class CreateCalendars < ActiveRecord::Migration[6.0]
  def change
    create_table :calendars do |t|
      t.integer :year, null: false
      t.integer :month, null: false
      t.timestamps
    end
  end
end
