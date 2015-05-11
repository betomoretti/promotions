class CreditCard
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name, type: String
  field :quantity_digits, type: Integer
  field :bin_start, type: Integer
  field :quantity_code_security, type: Integer
  field :active, type: Boolean

  has_many :promotions

  after_create :initialize_boolean
  
  def initialize_boolean
    self.active = true
    self.save      
  end
end
