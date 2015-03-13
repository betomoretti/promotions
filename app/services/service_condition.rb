class ServiceCondition
    include ActiveModel::Model
    attr_accessor :id,:airline_id,:legal_description, :active, :start_date, :end_date, :promotions
    
    def add_complete_data_to_condition()
        condition = Condition.find(self.id)
        airline = Airline.find(self.airline_id) unless self.airline_id.blank?
        condition.assign_attributes(shortname: airline.name,airline: airline, legal_description: self.legal_description, start_date: self.start_date, end_date: self.end_date, active: self.active)
        condition
    end 
end