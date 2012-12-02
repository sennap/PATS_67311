class Medicine < ActiveRecord::Base
  
  # Relationships
  # -----------------------------
  has_many :animal_medicines
  has_many :animals, :through => :animal_medicines
  has_many :medicine_costs
  has_many :visit_medicines
  has_many :visits, :through => :vist_medicines

  # Scopes
  # -----------------------------
  scope :alphabetical, order('name')
  scope :depleted, where('stock_amount = ?', 0)
  scope :vaccines, where('vaccine = ?', true)
  scope :nonvaccines, where('vaccine = ?', false)
  
  # Validations
  # -----------------------------
  validates_presence_of :name
  validates_numericality_of :stock_amount, :only_integer => true, :greater_than_or_equal_to => 0
  
  # Other methods
  # -----------------------------
  def is_vaccine?
    vaccine
  end
  
  def current_cost_per_unit
    curr_cost_of_medicine = self.medicine_costs.current
    return nil if curr_cost_of_medicine.empty?
    curr_cost_of_medicine.first.cost_per_unit
  end
  
end
