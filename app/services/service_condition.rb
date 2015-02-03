class ServiceCondition
    include ActiveModel::Model
    attr_accessor :airline,:legal_description, :start_date, :end_date, :promotions
    
    def add_complete_data_to_condition
        Condition.new(airline: self.airline, legal_description: self.legal_description, start_date: self.start_date, end_date: self.end_date, promotions: self.promotions)
    end 
end