class Coefficient
  include Mongoid::Document
  include Mongoid::Timestamps

  field :quota, type: String
  field :value, type: BigDecimal
  field :start_date, type: Date
  field :end_date, type: Date
  field :active, type: Boolean

  belongs_to :credit_card
  belongs_to :condition
  
  validates_presence_of :value, message: "Debe ingresar un valor para el coeficiente"
  validates_presence_of :start_date, message: "Debe seleccionar una fecha de inicio"
  validates_presence_of :end_date, message: "Debe seleccionar una fecha de fin"  
  validates_presence_of :credit_card, message: "Debe seleccionar una tarjeta de credito"  
  validates :quota, :presence => {:message => 'Debe ingresar cuotas. '}
  validate :dates, unless: "start_date.nil? || end_date.nil?"
  validate :format_of_quota

  # sd = start_date, ed= end_date
  def between_dates(sd, es)
    return true if sd < self.start_date && es > self.end_date
    return false
  end

  private
    def dates
      errors.add(:dates, "La fecha de inicio debe ser anterior a la fecha de fin") if self.start_date > self.end_date
    end
    
    def format_of_quota
      errors.add(:quota, "Las cuotas deben ser del tipo 3, 6, 12, etc. ") unless /[^0-9]/.match(self.quota.delete(' ')).nil?
    end
end
