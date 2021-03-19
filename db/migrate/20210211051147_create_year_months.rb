# frozen_string_literal: true

class CreateYearMonths < ActiveRecord::Migration[6.0]
  def change
    create_table :year_months do |t|
      t.integer :year_month, null: false
      t.timestamps
    end
  end
end
