require 'test_helper'

class CoefficientTest < ActiveSupport::TestCase

    test "validates credit_card association" do
        assert_not Coefficient.new(start_date: Date.today(), end_date: Date.today()+30,quota: "3", active: true, value: "1,304" , active: true ).save
        credit_card = CreditCard.create(name:"Visa", quantity_digits: 15, quantity_code_security: 3, bin_start: 4542)
        assert Coefficient.new(start_date: Date.today(), end_date: Date.today()+30,quota: "3", active: true, value: "1,304", credit_card: credit_card ).save, "No persiste la promocion que no tiene una tarjeta asociada"
    end

    test "shouldn't save coefficient without dates" do
        credit_card = CreditCard.create(name:"Visa", quantity_digits: 15, quantity_code_security: 3, bin_start: 4542)
        assert_not Coefficient.new(quota: "3", value: "1,304", active: true, credit_card: credit_card ).save
    end

    test "between dates" do 
        c = Coefficient.new(start_date: Date.today(),  end_date: Date.today()+100)
        assert c.between_dates(Date.today()-2,Date.today()+102)
        assert_not c.between_dates(Date.today()+10,Date.today()+98)
        assert_not c.between_dates(Date.today()-10,Date.today()+98)
        assert_not c.between_dates(Date.today()+2,Date.today()+102)
    end 
end
