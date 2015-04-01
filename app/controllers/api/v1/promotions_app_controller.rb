class Api::V1::PromotionsAppController < ApplicationController
    skip_before_filter :cas_filter, :current_user
    skip_before_filter  :verify_authenticity_token
    respond_to :json

    def airlines_credit_cards_banks_data
        @airlines = Airline.all
        @credit_cards = CreditCard.all
        @banks = Bank.all
    end
end
