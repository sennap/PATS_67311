class VisitMedicine < ActiveRecord::Base
  
  # Relationships
  # -----------------------------
  belongs_to :medicine
  belongs_to :visit
  has_one :pet, :through => :visit

  # Scopes
  # -----------------------------
  scope :for_medicine,  lambda { |medicine_id| where("medicine_id = ?", medicine_id) }
  scope :for_visit,     lambda { |visit_id| where("visit_id = ?", visit_id) }
  
  # Validations
  # -----------------------------
  validates_numericality_of :discount, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 0
  validates_numericality_of :units_given, :greater_than => 0, :only_integer => true
  
end
