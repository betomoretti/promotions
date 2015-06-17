class Api::V1::PromotionsAppController < ApplicationController
    skip_before_filter :cas_filter, :current_user
    skip_before_filter  :verify_authenticity_token
    respond_to :json

    def airlines_credit_cards_banks_data
        # return all airlines, credit cards and banks.
        @airlines = Airline.all
        @credit_cards = CreditCard.all
        @banks = Bank.all
    end


    

    def compatible_promotions # retrieves all the promotions that match with the given airline id, credit card id and bank id
        @airline_id=params["airline"]
        @credit_card_id=params["credit_card"]
        @bank_id=params["bank"]
        @cuotas = params["quota"]
    #makes the query only if airline, credit card or bank are specified. Otherwise, it just return all promtions. 
        form = Api::V1::SearchForm.new(airline_id:@airline_id,credit_card_id:@credit_card_id,bank_id:@bank_id, cuotas:@cuotas)  
        if @airline_id == '' && @credit_card_id == '' && @bank_id == '' && @cuotas == ''  
            @promotions = Promotion.where(:active => true).where("end_date >= ?",Date.today)
        else           
            @promotions = form.search_promotions unless form.search_promotions.blank? 
        end
    end

    def compatible_coefficients # Devuelve los coeficientes en base a aerolinea, banco y cuotas que se seleccione. En caso de seleccionar un monto, se devuelve el resultado.
        @airline_id=params["airline"]
        @credit_card_id=params["credit_card"]
        @cuotas=params["cuotas"]
        @monto=params["monto"]
        # looks for the compatible coefficient given an airline, credit card, quota and amount.
        form = Api::V1::SearchForm.new(airline_id:@airline_id,credit_card_id:@credit_card_id,monto:@monto,cuotas:@cuotas)       
        @coefficients = form.search_coefficients.entries unless form.search_coefficients.blank?        
        # this query retrieve the coefficient -> value from the compatible coefficient (first, it should be only one)
        if @coefficients.present?
            if @monto.present? && @cuotas.present? && @credit_card_id.present? && @airline_id.present?
              if @coefficients.first.values.where(:quota => @cuotas).present? 
                 @value = @coefficients.first.values.where(:quota => @cuotas).entries.first.value.to_s.gsub(',', '.').to_f
                 @result = @value * BigDecimal(@monto.to_s)   # asigna a result el producto de el value de la cuota seleccionada y el monto. el value, en caso de estar escrito con , se pasa a . para que se pueda realizar la multiplicación.
              end
            end
        end
    end


    def all_promotions
        # retrieve all the promotions
        @promotions=Promotion.all
    end

    def airlines_credit_cards_banks_promotions_data # retrieves all arirlines, credit cards, promotions and banks. Also, it can have an airline param in order to retrieve specific promotions.
        # the airline param comes in the url
        @airline_id=params["airline"]
        @airlines = Airline.all.order(:name)
        @credit_cards = CreditCard.all
        @banks = Bank.all        
        # the next lines retrieve the promotions given an airline (or not)
        if @airline_id == ''   
            @promotions = Promotion.where(:active => true).where("end_date >= ?",Date.today)
        else        
            form = Api::V1::SearchForm.new(airline_id:@airline_id)
            @promotions = form.search_promotions unless form.search_promotions.blank? 
        end     
    end    


end
