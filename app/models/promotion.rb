class Promotion
  include Mongoid::Document
  include Mongoid::Timestamps

  field :quota, type: String
  field :bin, type: String

  belongs_to :bank
  belongs_to :credit_card
  belongs_to :condition

  validates :quota, :presence => {:message => 'Debe ingresar cuotas. '}
  validates :bin, :presence => {:message => 'Debe ingresar bins. '}
  validate :bank_or_credit_card_not_nil
  validate :format_of_quota
  validate :format_of_bin

  private
    def bank_or_credit_card_not_nil
        errors.add(:bank_or_credit_card, "Debe seleccionar un banco y/o una tarjeta de credito. ") if self.bank.nil? && self.credit_card.nil?
    end

    def format_of_quota
        errors.add(:quota, "Las cuotas deben ser del tipo 3, 6, 12, etc. ") unless /[^0-9\,y]/.match(self.quota.delete(' ')).nil?
    end

    def format_of_bin
        errors.add(:bin, "Los bin deben ser tipo 4442, 4455, etc. ") unless /[^0-9\,]/.match(self.bin.delete(' ')).nil?      
    end
end
