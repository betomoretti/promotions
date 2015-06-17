class Api::V1::SearchForm
    include ActiveModel::Model
    attr_accessor :airline_id,:credit_card_id,:bank_id,:monto,:cuotas

    # before_filter :reject_blank

    # def reject_blank
    #     return [] if self.airline_id.blank? && self.credit_card_id.blank? && self.bank_id.blank?
    # end

    def search_promotions #search and return promotions given the credit card, airline and bank ids unless theese are not especified
        if self.airline_id.present? || self.credit_card_id.present? || self.bank_id.present? || self.cuotas.present?
        @promotions=Promotion.where(:active => true).where("end_date >= ?",Date.today).by_credit_card(self.credit_card_id).by_airline(self.airline_id).by_bank(self.bank_id).by_cuotas(self.cuotas)
        end
    end

    def search_coefficients #search and return coefficients given the credit card, airline and bank ids unless theese are not especified
        if self.airline_id.present? || self.credit_card_id.present? || self.cuotas.present?
            @coefficients=Coefficient.where(:active => true).by_credit_card(self.credit_card_id).by_airline(self.airline_id)
        end
    end   

end