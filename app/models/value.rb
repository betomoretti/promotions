class Value < ActiveRecord::Base

  has_many :promotions
  belongs_to :coefficient

  validates_presence_of :value, message: "Debe ingresar un valor. "
  validates :quota, :presence => {:message => 'Debe ingresar cuotas. '}
  validate :format_of_quota

  private
    def format_of_quota
      errors.add(:quota, "Las cuotas deben ser del tipo 3, 6, 12, etc. ") unless /[^0-9]/.match(self.quota.delete(' ')).nil?
    end
end