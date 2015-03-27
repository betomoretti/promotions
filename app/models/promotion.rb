class Promotion
  include Mongoid::Document
  include Mongoid::Timestamps

  field :quota, type: String
  field :bin, type: String
  field :comerce_number, type: String
  field :observations, type: String
  field :start_date, type: Date
  field :end_date, type: Date
  field :active, type: Boolean

  belongs_to :bank
  belongs_to :credit_card
  belongs_to :condition

  validates_presence_of :start_date, message: "Debe seleccionar una fecha de inicio. "
  validates_presence_of :end_date, message: "Debe seleccionar una fecha de fin. "  
  validates :quota, :presence => {:message => 'Debe ingresar cuotas. '}
  validate :bank_or_credit_card_not_nil
  validate :dates, unless: "start_date.nil? || end_date.nil?"
  validate :format_of_quota
  validate :format_of_bin

  # sd = start_date, ed= end_date
  def between_dates(sd, es)
    return true if sd <= self.start_date && es >= self.end_date
    return false
  end

  private
    def dates
      errors.add(:dates, "La fecha de inicio debe ser anterior a la fecha de fin") if self.start_date > self.end_date
    end
    
    def bank_or_credit_card_not_nil
      errors.add(:bank_or_credit_card, "Debe seleccionar un banco y/o una tarjeta de credito. ") if self.bank.nil? && self.credit_card.nil?
    end

    def format_of_quota
      errors.add(:quota, "Las cuotas deben ser del tipo 3, 6, 12, etc. ") unless /[^0-9\,y]/.match(self.quota.delete(' ')).nil?
    end

    def format_of_bin
      errors.add(:bin, "Los bin deben ser tipo 4442, 4455, 5520-5540 etc. ") unless /[^0-9\,-]/.match(self.bin.delete(' ')).nil?      
    end

end
