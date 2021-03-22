class CreateReviewRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :review_records do |t|
      t.references :note, null: false, foreign_key: true
      t.integer :reviewed_count, default: 0
      t.date :last_updated_date

      t.timestamps
    end
  end
end
