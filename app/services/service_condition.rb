class ServiceCondition
    include ActiveModel::Model
    attr_accessor :id,:airline,:legal_description, :start_date, :end_date, :promotions
    
    def add_complete_data_to_condition
        condition = Condition.find(self.id)
        condition.assign_attributes(airline_id: self.airline, legal_description: self.legal_description, start_date: self.start_date, end_date: self.end_date)
        self.promotions.to_a.flatten!.uniq.each do |p_id|
            Promotion.where(id: p_id).update(condition_id: self.id)            
        end        
        condition
    end 
end