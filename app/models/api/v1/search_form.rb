class Api::V1::SearchForm
    include ActiveModel::Model
    attr_accessor :airline_id,:credit_card_id,:bank_id,:monto,:cuotas

    # before_filter :reject_blank

    # def reject_blank
    #     return [] if self.airline_id.blank? && self.credit_card_id.blank? && self.bank_id.blank?
    # end

    def search_promotions #search and return promotions given the credit card, airline and bank ids unless theese are not especified
        # if self.airline_id.present? ^ self.credit_card_id.present? ^ self.bank_id.present?
        #     @promotions = Promotion.by_credit_card(self.credit_card_id).where({'end_date' => {'$gte' => Date.today}}).entries if self.credit_card_id.present?
        #     @promotions = Promotion.by_bank(self.bank_id).where({'end_date' => {'$gte' => Date.today}}).entries if self.bank_id.present?
        #     @promotions = Promotion.by_airline(self.airline_id).where({'end_date' => {'$gte' => Date.today}}).entries if self.airline_id.present?
        #     if self.cuotas.present?
        #         @promotions.delete_if{|p|  !((p.quota =~ /#{self.cuotas}(.*)/) || (p.quota =~ /(.*)#{self.cuotas}/ ) || (p.quota =~ /,#{self.cuotas},/ ))}
        #     end              
        # end  
        # if self.cuotas.present? && self.airline_id.blank? && self.credit_card_id.blank? && self.bank_id.blank?
        #     @promotions = Promotion.all.entries
        #     @promotions.delete_if{|p|  !((p.quota =~ /#{self.cuotas}(.*)/) || (p.quota =~ /(.*)#{self.cuotas}/ ) || (p.quota =~ /,#{self.cuotas},/ ))}
        # end   
        # if self.credit_card_id.present? && self.bank_id.present?
            @promotions = Array.new
            porTarjeta = Promotion.by_credit_card(self.credit_card_id).where({'end_date' => {'$gte' => Date.today}}) if self.credit_card_id.present?
            porBanco = Promotion.by_bank(self.bank_id).where({'end_date' => {'$gte' => Date.today}}) if self.bank_id.present?
            porAerolinea = Promotion.by_airline(self.airline_id).where({'end_date' => {'$gte' => Date.today}})  if self.airline_id.present?
            noCoincidenBancos = Promotion.and({:bank_id.ne => self.bank_id},{:bank_id.ne => nil},) if self.bank_id.present?
            noCoincidentarjetas = Promotion.and({:credit_card_id.ne => self.credit_card_id},{:credit_card_id.ne => nil},) if self.credit_card_id.present?
            noCoincidenAerolineas = Promotion.not_in(condition_id: (Condition.any_of({:airline_id => self.airline_id},{:airline_id => nil}).pluck(:id))) if self.airline_id.present? 
            @promotions = @promotions + porTarjeta.entries if self.credit_card_id.present?
            @promotions = @promotions + porBanco.entries if self.bank_id.present?
            @promotions = @promotions + porAerolinea.entries if self.airline_id.present?            
            @promotions = @promotions - noCoincidentarjetas.entries if self.credit_card_id.present?
            @promotions = @promotions - noCoincidenBancos.entries if self.bank_id.present?
            @promotions = @promotions - noCoincidenAerolineas.entries if self.airline_id.present?
            @promotions.uniq!
            if self.cuotas.present?
                @promotions.delete_if{|p|  !((p.quota =~ /#{self.cuotas}(.*)/) || (p.quota =~ /(.*)#{self.cuotas}/ ) || (p.quota =~ /,#{self.cuotas},/ ))}
            end    
            if (self.cuotas.present?) && (self.credit_card_id.blank? && self.bank_id.blank? && self.airline_id.blank?) 
                @promotions = Promotion.all.entries.delete_if{|p|  !((p.quota =~ /#{self.cuotas}(.*)/) || (p.quota =~ /(.*)#{self.cuotas}/ ) || (p.quota =~ /,#{self.cuotas},/ ))}
            end            
        # end
        p @promotions
        @promotions
    end    

    def search_coefficients #search and return coefficients given the credit card, airline and bank ids unless theese are not especified
        if self.airline_id.present? || self.credit_card_id.present? || self.cuotas.present?
            @coefficients=Coefficient.where(:active => true).by_credit_card(self.credit_card_id).by_airline(self.airline_id)
        end
    end    

end