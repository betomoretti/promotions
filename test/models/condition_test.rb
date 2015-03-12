require 'test_helper'

class ConditionTest < ActiveSupport::TestCase
    
    setup :initialize_conditions
    
    test "get airline" do
        @conds.each do |val|
            assert_equal val.airline.id, @air.id
        end
    end

    test "validate dates" do
        bank = Bank.create(name: "City bank")
        assert Condition.new(
            airline: Airline.first,
            active: true,
            start_date: Date.today()-20,
            end_date: Date.today()+100,
            legal_description: "Descripcion legal",
            promotions: [ 
                Promotion.create(start_date: Date.today()+1, end_date: Date.today()+40,quota: "3, 6, y 12", active: true, bin: "2312,3434,2345", bank: bank ), 
                Promotion.create( bin: "4656,3340", quota: "3 y 6", start_date: Date.today()+1 , end_date: Date.today()+40, bank:  bank), 
                Promotion.create( bin: "4656,3340", quota: "3 y 6", start_date: Date.today()+1 , end_date: Date.today()+40, bank:  bank)
            ]).save
        assert_not Condition.new(
            airline: Airline.first,
            active: true,
            start_date: Date.today(),
            end_date: Date.today()-2,
            legal_description: "Descripcion legal",
            promotions: [ 
                Promotion.create(start_date: Date.today()+1, end_date: Date.today()+40,quota: "3, 6, y 12", active: true, bin: "2312,3434,2345", bank: bank ), 
                Promotion.create( bin: "4656,3340", quota: "3 y 6", start_date: Date.today()+1 , end_date: Date.today()+40, bank:  bank), 
                Promotion.create( bin: "4656,3340", quota: "3 y 6", start_date: Date.today()+1 , end_date: Date.today()+40, bank:  bank)
            ]).save
    end

    test "shouldn't save condition with bad dates in promotions" do
        bank = Bank.create(name: "City bank")
        assert_not Condition.new(
            airline: Airline.first,
            active: true,
            start_date: Date.today()-20,
            end_date: Date.today()+100,
            legal_description: "Descripcion legal",
            promotions: [ 
                Promotion.create(start_date: Date.today()-25, end_date: Date.today()+40,quota: "3, 6, y 12", active: true, bin: "2312,3434,2345", bank: bank ), 
                Promotion.create( bin: "4656,3340", quota: "3 y 6", start_date: Date.today()+1 , end_date: Date.today()+102, bank:  bank), 
                Promotion.create( bin: "4656,3340", quota: "3 y 6", start_date: Date.today()+1 , end_date: Date.today()+40, bank:  bank)
            ]
        ).save
    end

    test "shouldn't save condition with bad dates in coefficients" do
        bank = Bank.create(name: "City bank")
        credit_card = CreditCard.create(name:"Visa", quantity_digits: 15, quantity_code_security: 3, bin_start: 4542)
        assert_not Condition.new(
            airline: Airline.first,
            active: true,
            start_date: Date.today()-20,
            end_date: Date.today()+100,
            legal_description: "Descripcion legal",
            promotions: [ 
                Promotion.create(start_date: Date.today()+1, end_date: Date.today()+40,quota: "3, 6, y 12", active: true, bin: "2312,3434,2345", bank: bank ), 
                Promotion.create( bin: "4656,3340", quota: "3 y 6", start_date: Date.today()+1 , end_date: Date.today()+40, bank:  bank), 
                Promotion.create( bin: "4656,3340", quota: "3 y 6", start_date: Date.today()+1 , end_date: Date.today()+40, bank:  bank)
            ],
            coefficients: [ 
                Coefficient.create(start_date: Date.today()-25, end_date: Date.today()+40,quota: "3", active: true, credit_card: credit_card, value: "1,203" ), 
                Coefficient.create(quota: "3", start_date: Date.today()+1 , end_date: Date.today()+102, active: true, credit_card: credit_card, value: "1,203"), 
                Coefficient.create(quota: "3", start_date: Date.today()+1 , end_date: Date.today()+40, active: true, credit_card: credit_card, value: "1,203")
            ]
        ).save
    end
end
