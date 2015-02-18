class ServiceCondition
    include ActiveModel::Model
    attr_accessor :id,:airline,:legal_description, :active, :start_date, :end_date, :promotions
    
    def add_complete_data_to_condition(dalete_all=false)
        condition = Condition.find(self.id)
        airline = Airline.find(self.airline) unless self.airline.blank?
        condition.assign_attributes(airline: airline, legal_description: self.legal_description, start_date: self.start_date, end_date: self.end_date, active: self.active)
        self.promotions.to_a.flatten.uniq.each do |p_id|
            Promotion.where(id: p_id).update(condition_id: self.id)            
        end        
        condition
    end 
end