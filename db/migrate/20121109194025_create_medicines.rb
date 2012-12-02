class CreateMedicines < ActiveRecord::Migration
  def change
    create_table :medicines do |t|
      t.string :name
      t.text :description
      t.integer :stock_amount
      t.string :method
      t.string :unit
      t.boolean :vaccine, :default => false

      t.timestamps
    end
  end
end
