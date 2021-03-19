# frozen_string_literal: true

class CreateGoals < ActiveRecord::Migration[6.0]
  def change
    create_table :goals do |t|
      t.string :goal_name
      t.references :calendar, foreign_key: true
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
