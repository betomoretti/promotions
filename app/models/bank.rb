class Bank
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name, type: String
  field :active, type: Boolean
  
  has_many :promotions

  after_create :initiliaze_boolean

  def initiliaze_boolean
    self.active = true
    self.save
  end

end
