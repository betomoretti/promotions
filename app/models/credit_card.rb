class CreditCard
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name, type: String
  field :quantity_digits, type: Integer
  field :bin_start, type: Integer
  field :quantity_code_security, type: Integer

  has_many :promotions
end
