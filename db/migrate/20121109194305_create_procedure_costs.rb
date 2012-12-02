class CreateProcedureCosts < ActiveRecord::Migration
  def change
    create_table :procedure_costs do |t|
      t.integer :procedure_id
      t.integer :cost
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
