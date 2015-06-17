class Promotion < ActiveRecord::Base

  # belongs_to :bank
  # belongs_to :credit_card
  belongs_to :condition

  validates_presence_of :start_date, message: "Debe seleccionar una fecha de inicio. "
  validates_presence_of :end_date, message: "Debe seleccionar una fecha de fin. "  
  validates :quota, :presence => {:message => 'Debe ingresar cuotas. '}
  validate :bank_or_credit_card_not_nil
  validate :dates, unless: "start_date.nil? || end_date.nil?"
  validate :format_of_quota
  validate :format_of_bin

  scope :by_airline, ->(desired_id) { where(:condition_id => Condition.by_airline(desired_id).pluck(:id)) if desired_id.present?  }
  scope :by_credit_card, ->(desired_id) { where(credit_card_id: [desired_id,nil]) if desired_id.present? }
  scope :by_bank, ->(desired_id) { where(bank_id: [desired_id,nil]) if desired_id.present? }  
  scope :by_cuotas, ->(desired_cuota) { where('quota like ? or quota like ? or quota like ? or quota like ?', desired_cuota,'%,' + desired_cuota, '%,' + desired_cuota +',%' ,desired_cuota + ',%') if desired_cuota.present?}


  def bank
    @bank ||= Bank.find self.bank_id unless self.bank_id.blank?#
  end
  def credit_card
    @credit_card ||= CreditCard.find self.credit_card_id unless self.credit_card_id.blank?#
  end  

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
