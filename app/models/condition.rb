class Condition
    include Mongoid::Document
    include Mongoid::ActiveRecordBridge
    include Mongoid::Timestamps

    field :start_date, type: Time
    field :end_date, type: Time
    field :legal_description, type: String

    belongs_to_record :airline
    has_many :promotions
    
    validates_presence_of :start_date
    validates_presence_of :end_date
    validate :dates

    private
        def dates
            errors.add(:dates, "La fecha de inicio debe ser menor a la fecha de fin") if self.start_date < Date.today || self.start_date >= self.end_date ||  self.end_date < Date.today
        end
end
