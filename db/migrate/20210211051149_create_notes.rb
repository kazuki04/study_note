class CreateNotes < ActiveRecord::Migration[6.0]
  def change
    create_table :notes do |t|
      t.string :highlight, null: false
      t.string :excerpt, null: false
      t.date :written_day, null: false
      t.integer :reviewed, default: 0
      t.references :user, foregin_key: true
      t.references :calendar,foregin_key: true 
      t.timestamps
    end
  end
end
