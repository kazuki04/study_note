class CreateNotes < ActiveRecord::Migration[6.0]
  def change
    create_table :notes do |t|
      t.string :highlight, null: false
      t.string :excerpt, null: false
      t.text :body, null: false
      t.date :written_day, null: false
      t.timestamps
    end
  end
end
