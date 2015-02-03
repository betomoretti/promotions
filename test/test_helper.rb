ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'database_cleaner'

class ActiveSupport::TestCase
    # Add more helper methods to be used by all tests here...

    def teardown
        DatabaseCleaner[:mongoid, {:connection => :promotions_test}].clean_with(:truncation)
    end

    private
        def initialize_bank
            @bank = Bank.create(name: "Galicia")
        end

        def initialize_conditions
            @conds = []
            @air = Airline.first()
            100.times do |n|
                @conds.push(Condition.create(start_date: Date.today(), end_date: Date.today()+100, airline: @air))
            end
            @air.conditions = @conds
        end

        def initialiaze_promotion
            @promotion = Promotion.create(quota: "3, 6, y 12", bin: "2312,3434,2345", legal_description: "Descripcion legal" )
            @bank = Bank.create(name: "Galicia")
            @credit_card = CreditCard.create(name:"Visa", quantity_digits: 15, quantity_code_security: 3, bin_start: 4542)
            @promotion.bank = @bank
            @promotion.credit_card = @credit_card 
            @promotion.save
        end

end
