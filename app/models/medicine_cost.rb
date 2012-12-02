class MedicineCost < ActiveRecord::Base
  
  # Relationships
  # -----------------------------
  belongs_to :medicine

  # Scopes
  # -----------------------------
  scope :alphabetical,  joins(:medicines).order('name')
  scope :by_cost,       order('cost_per_unit')
  scope :current,       where("end_date IS NULL")
  scope :past,          where("end_date < ?", Time.now)
  scope :for_medicine,  lambda { |medicine_id| where("medicine_id = ?", medicine_id) }
  
  
  # Validations
  # -----------------------------
  validates_numericality_of :cost_per_unit, :only_integer => true, :greater_than_or_equal_to => 0
  validates_date :start_date
  validates_date :end_date, :allow_blank => true

end
