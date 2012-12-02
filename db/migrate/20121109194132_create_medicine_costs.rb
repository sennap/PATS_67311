class CreateMedicineCosts < ActiveRecord::Migration
  def change
    create_table :medicine_costs do |t|
      t.integer :medicine_id
      t.integer :cost_per_unit
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
