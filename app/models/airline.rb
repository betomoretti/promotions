class Airline < ActiveRecord::Base

    has_many_documents :conditions

    def conditions=(arrayOfConditions)
        arrayOfConditions.each do | condition |
            condition.airline = self
            condition.save
        end
    end
end