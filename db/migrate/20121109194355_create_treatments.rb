class CreateTreatments < ActiveRecord::Migration
  def change
    create_table :treatments do |t|
      t.integer :visit_id
      t.integer :procedure_id
      t.boolean :successful
      t.decimal :discount, :precision => 4, :scale => 2, :default => 0.00

      t.timestamps
    end
  end
end
