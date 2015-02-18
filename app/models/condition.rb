class Condition
    include Mongoid::Document
    include Mongoid::ActiveRecordBridge
    include Mongoid::Timestamps

    field :start_date, type: Date
    field :end_date, type: Date
    field :legal_description, type: String
    field :active, type: Boolean

    belongs_to_record :airline
    has_many :promotions
    
    validates_presence_of :start_date
    validates_presence_of :end_date
    validate :dates, unless: "start_date.nil? || end_date.nil?"
    validate :promotions_rel

    private
        def dates
            errors.add(:dates, "La fecha de inicio debe ser anterior a la fecha de fin") if self.start_date < Date.today || self.start_date > self.end_date ||  self.end_date < Date.today
        end

        def airline_val
            errors.add(:airline, "Debe seleccionar una aerolinea") if self.airline.blank?
        end

        def promotions_rel
            errors.add(:promotions, "Debe crear al menos una promocion") if self.promotions.blank?
        end
end
