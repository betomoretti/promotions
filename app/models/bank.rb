class Bank
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name, type: String

  has_many :promotions
end
