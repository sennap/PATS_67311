class ProcedureCost < ActiveRecord::Base
  
  # Relationships
  # -----------------------------
  belongs_to :medicine

  # Scopes
  # -----------------------------
  scope :alphabetical,  joins(:procedures).order('name')
  scope :by_cost,       order('cost')
  scope :current,       where("end_date IS NULL")
  scope :past,          where("end_date < ?", Time.now)
  scope :for_procedure,  lambda { |procedure_id| where("procedure_id = ?", procedure_id) }
  
  
  # Validations
  # -----------------------------
  validates_numericality_of :cost, :only_integer => true, :greater_than_or_equal_to => 0
  validates_date :start_date
  validates_date :end_date, :allow_blank => true

end
