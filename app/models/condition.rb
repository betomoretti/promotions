class Condition
    include Mongoid::Document
    include Mongoid::ActiveRecordBridge
    include Mongoid::Timestamps

    field :shortname, type: String
    field :start_date, type: DateTime
    field :end_date, type: DateTime
    field :legal_description, type: String
    field :active, type: Boolean

    belongs_to_record :airline
    has_many :promotions
    has_many :coefficients
    
    validates_presence_of :start_date
    validates_presence_of :end_date
    validate :dates, unless: "start_date.nil? || end_date.nil?"
    
    validate :promotions_rel
    validate :coefficients_rel
    validate :promotions_dates, unless: "promotions.blank?"
    validate :coefficients_dates, unless: "coefficients.blank?"
    
    scope :by_airline, ->(desired_id) { where(airline_id: desired_id ) }

    def have_promotions
        if self.promotions.empty?
            return false        
        end
        return true
    end

    def validate_dates_of_my_promotions
        self.promotions.each do |promotion| 
            return true if !promotion.between_dates(self.start_date, self.end_date)
        end
        return false
    end

    def validate_dates_of_my_coefficients
        self.coefficients.each do |coefficient| 
            return true if !coefficient.between_dates(self.start_date, self.end_date)
        end
        return false
    end  

    private
        def dates
            errors.add(:dates, "La fecha de inicio debe ser anterior a la fecha de fin.") if self.start_date > self.end_date
        end

        def airline_val
            errors.add(:airline, "Debe seleccionar una aerolinea.") if self.airline.blank?
        end

        def promotions_rel
            errors.add(:promotions, "Debe crear al menos una promocion.") if self.promotions.blank?
        end

        def coefficients_rel
            errors.add(:coefficients, "Debe crear al menos un coeficiente.") if self.coefficients.blank?
        end

        def promotions_dates
            errors.add(:promotions, "Las fechas de las promociones deben estar dentro del rango de fechas de la condicion.") if self.validate_dates_of_my_promotions
        end

        def coefficients_dates
            errors.add(:coefficients, "Las fechas de los coeficientes deben estar dentro del rango de fechas de la condicion.") if self.validate_dates_of_my_coefficients
        end       
end
