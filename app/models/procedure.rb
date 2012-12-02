class Procedure < ActiveRecord::Base
  
  # Relationships
  # -----------------------------
  has_many :procedure_costs
  has_many :treatments
  has_many :visits, :through => :treatments

  # Scopes
  # -----------------------------
  scope :alphabetical, order('name')
  scope :active, where('active = ?', true)
  scope :inactive, where('active = ?', false)
  
  # Validations
  # -----------------------------
  validates_presence_of :name
  validates_numericality_of :length_of_time, :only_integer => true, :greater_than => 0
  
  # Other methods
  # -----------------------------  
  def current_cost
    curr_cost_of_procedure = self.procedure_costs.current    
    return nil if curr_cost_of_procedure.empty?
    curr_cost_of_procedure.first.cost
  end
  
end
