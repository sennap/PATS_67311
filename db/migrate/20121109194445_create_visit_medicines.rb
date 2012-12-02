class CreateVisitMedicines < ActiveRecord::Migration
  def change
    create_table :visit_medicines do |t|
      t.integer :visit_id
      t.integer :medicine_id
      t.integer :units_given
      t.decimal :discount, :precision => 4, :scale => 2, :default => 0.00

      t.timestamps
    end
  end
end
