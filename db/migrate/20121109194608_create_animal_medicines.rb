class CreateAnimalMedicines < ActiveRecord::Migration
  def change
    create_table :animal_medicines do |t|
      t.integer :animal_id
      t.integer :medicine_id
      t.integer :recommended_num_of_units

      t.timestamps
    end
  end
end
