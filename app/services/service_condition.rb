class ServiceCondition
    include ActiveModel::Model
    attr_accessor :id,:airline_id,:legal_description, :active, :start_date, :end_date, :promotions
    
    def add_complete_data_to_condition(delete_all=false)
        condition = Condition.find(self.id)
        airline = Airline.find(self.airline_id) unless self.airline_id.blank?
        condition.assign_attributes(airline: airline, legal_description: self.legal_description, start_date: self.start_date, end_date: self.end_date, active: self.active)
        Promotion.delete_all(condition_id: self.id) if delete_all
        self.promotions.to_a.flatten.uniq.each do |p_id|
            Promotion.where(id: p_id).update(condition_id: condition.id)            
        end        
        condition.save(validate: false)
        condition
    end 
end