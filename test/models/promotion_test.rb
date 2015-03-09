require 'test_helper'

class PromotionTest < ActiveSupport::TestCase
    setup :initialiaze_promotion

    test "model and associations" do
        assert_not_nil @promotion.bank
        assert_not_nil @promotion.credit_card
    end

    test "validates bank or credit_card association" do
        assert_not Promotion.new(start_date: Date.today(), end_date: Date.today()+30,quota: "3, 6, y 12", active: true, bin: "2312,3434,2345", active: true ).save
        bank = Bank.create(name: "Galicia")
        credit_card = CreditCard.create(name:"Visa", quantity_digits: 15, quantity_code_security: 3, bin_start: 4542)
        assert Promotion.new(start_date: Date.today(), end_date: Date.today()+30,quota: "3, 6, y 12", active: true, bin: "2312,3434,2345", bank: bank ).save, "No persiste la promocion que solo tiene banco"
        assert Promotion.new(start_date: Date.today(), end_date: Date.today()+30,quota: "3, 6, y 12", active: true, bin: "2312,3434,2345", credit_card: credit_card ).save, "No persiste la promocion que solo tiene tarjea"
        assert Promotion.new(start_date: Date.today(), end_date: Date.today()+30,quota: "3, 6, y 12", active: true, bin: "2312,3434,2345", credit_card: credit_card, bank: bank ).save, "No persiste la promocion que tiene banco y tarjeta"
    end

    test "validations of quota and bin on save" do
        bank = Bank.create(name: "Galicia")
        assert Promotion.new(start_date: Date.today(), end_date: Date.today()+30,quota: "3, 6, y 12", active: true, bin: "2312,3434,2345", bank: bank ).save
        assert Promotion.new(start_date: Date.today(), end_date: Date.today()+30,quota: "3", active: true, bin: "2312", bank: bank ).save 
        assert_not Promotion.new(start_date: Date.today(), end_date: Date.today()+30,quota: "3, 6eee, y 12", active: true, bin: "2312,3434+++,2345", bank: bank ).save
        assert_not Promotion.new(start_date: Date.today(), end_date: Date.today()+30,quota: "3, 6, eery 12", active: true, bin: "2312,3434,234`qw+5", bank: bank ).save
    end

    test "shouldn't save promotion without dates" do
        bank = Bank.create(name: "Galicia")
        assert_not Promotion.new(quota: "3, 6eee, y 12", active: true, bin: "2312,3434+++,2345", bank: bank ).save
    end

    test "between dates" do 
        p = Promotion.new(start_date: Date.today(),  end_date: Date.today()+100)
        assert p.between_dates(Date.today()-2,Date.today()+102)
        assert_not p.between_dates(Date.today()+10,Date.today()+98)
        assert_not p.between_dates(Date.today()-10,Date.today()+98)
        assert_not p.between_dates(Date.today()+2,Date.today()+102)
    end 
end
