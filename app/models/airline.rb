class Airline < ActiveRecord::Base

    has_many_documents :conditions

    validates_presence_of :name, message: "Debe ingresar un nombre para la aerolínea"
    validates_presence_of :iata_code, message: "Debe ingresar un iata_code para la aerolínea"
    validates_presence_of :max_age_child, message: "Debe ingresar una edad"
    validates_presence_of :max_age_infant, message: "Debe ingresar una edad"        

    def conditions=(arrayOfConditions)
        arrayOfConditions.each do | condition |
            condition.airline = self
            condition.save
        end
    end
end