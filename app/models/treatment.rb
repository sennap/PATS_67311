class Treatment < ActiveRecord::Base

  # Relationships
  # -----------------------------
  belongs_to :procedure
  belongs_to :visit
  has_one :pet, :through => :visit

  # Scopes
  # -----------------------------
  scope :for_procedure, lambda { |procedure_id| where("procedure_id = ?", procedure_id) }
  scope :for_visit,     lambda { |visit_id| where("visit_id = ?", visit_id) }
  
  # Validations
  # -----------------------------
  validates_numericality_of :discount, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 0
  
end
