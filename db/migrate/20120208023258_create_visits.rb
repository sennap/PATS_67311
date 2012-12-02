class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.integer :pet_id
      t.date :date
      t.integer :weight
      t.text :notes
      t.boolean :overnight_stay
      t.integer :total_charge

      t.timestamps
    end
  end
end
