class Visit < ActiveRecord::Base
  
  # Relationships
  # -----------------------------
  belongs_to :pet
  has_one :owner, :through => :pet
  has_many :visit_medicines
  has_many :medicines, :through => :visit_medicines
  has_many :treatments
  has_many :procedures, :through => :treatments
  
  # Scopes
  # -----------------------------
  # by default, order by visits in descending order (most recent first)
   scope :chronological, order('date DESC')
   # get all the visits by a particular pet
   scope :for_pet, lambda {|pet_id| where('pet_id = ?', pet_id) }
   # get the last X visits
   scope :last, lambda {|num| limit(num).order('date DESC') }
   # get all visits that resulted in overnight stay
   scope :overnights, where('overnight_stay = ?', true)
  
  # Validations
  # -----------------------------
  validates_presence_of :pet_id
  validates_date :date
  # weight must be an integer greater than 0 and less than 100 (none of our animal types will exceed)
  validates_numericality_of :weight, :only_integer => true, :greater_than => 0, :less_than => 100, :allow_blank => true
  validates_numericality_of :total_charge, :only_integer => true, :greater_than_or_equal_to => 0
  
end
