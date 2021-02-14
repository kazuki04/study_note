class CreateGoalManagements < ActiveRecord::Migration[6.0]
  def change
    create_table :goal_managements do |t|
      t.string :goal_name
      t.references :year_month, foreign_key: true
      t.timestamps
    end
  end
end
