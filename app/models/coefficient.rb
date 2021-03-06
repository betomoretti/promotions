class Coefficient
  include Mongoid::Document
  include Mongoid::Timestamps

  field :start_date, type: Date
  field :end_date, type: Date
  field :active, type: Boolean

  belongs_to :credit_card
  belongs_to :condition
  has_many :values, :dependent => :delete
  
  accepts_nested_attributes_for :values, :allow_destroy => true, :reject_if => :all_blank

  validates_presence_of :start_date, message: "Debe seleccionar una fecha de inicio"
  validates_presence_of :end_date, message: "Debe seleccionar una fecha de fin"  
  validates_presence_of :credit_card, message: "Debe seleccionar una tarjeta de credito"  
  validate :dates, unless: "start_date.nil? || end_date.nil?"
  

  scope :by_airline, ->(desired_id) { any_in(condition_id: Condition.by_airline(desired_id).pluck(:id)) if desired_id.present?  }
  scope :by_credit_card, ->(desired_id) { where(credit_card_id: desired_id ) if desired_id.present? }



  # sd = start_date, ed= end_date
  def between_dates(sd, es)
    return true if sd <= self.start_date && es >= self.end_date    
    return false
  end

  private
    def dates
      errors.add(:dates, "La fecha de inicio debe ser anterior a la fecha de fin") if self.start_date > self.end_date
    end
end
