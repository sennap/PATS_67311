class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.string :notable_type
      t.integer :notable_id
      t.string :title
      t.text :content
      t.integer :user_id
      t.date :date

      t.timestamps
    end
  end
end
