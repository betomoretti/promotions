require 'test_helper'

class PromotionTest < ActiveSupport::TestCase
    setup :initialiaze_promotion

    test "model and associations" do
        assert_not_nil @promotion.bank
        assert_not_nil @promotion.credit_card
    end

    test "validates bank or credit_card association" do
        assert_not Promotion.create(quota: "3, 6, y 12", bin: "2312,3434,2345", legal_description: "Descripcion legal" ).persisted?
        bank = Bank.create(name: "Galicia")
        credit_card = CreditCard.create(name:"Visa", quantity_digits: 15, quantity_code_security: 3, bin_start: 4542)
        assert Promotion.create(quota: "3, 6, y 12", bin: "2312,3434,2345", legal_description: "Descripcion legal", bank: bank ).persisted?, "No persiste la promocion que solo tiene banco"
        assert Promotion.create(quota: "3, 6, y 12", bin: "2312,3434,2345", legal_description: "Descripcion legal", credit_card: credit_card ).persisted?, "No persiste la promocion que solo tiene tarjea"
        assert Promotion.create(quota: "3, 6, y 12", bin: "2312,3434,2345", legal_description: "Descripcion legal", credit_card: credit_card, bank: bank ).persisted?, "No persiste la promocion que tiene banco y tarjeta"
    end

    test "validations of quota and bin on save" do
        bank = Bank.create(name: "Galicia")
        assert Promotion.create(quota: "3, 6, y 12", bin: "2312,3434,2345", legal_description: "Descripcion legal", bank: bank ).persisted?
        assert Promotion.create(quota: "3", bin: "2312", legal_description: "Descripcion legal", bank: bank ).persisted? 
        assert_not Promotion.create(quota: "3, 6eee, y 12", bin: "2312,3434+++,2345", legal_description: "Descripcion legal", bank: bank ).persisted?
        assert_not Promotion.create(quota: "3, 6, eery 12", bin: "2312,3434,234`qw+5", legal_description: "Descripcion legal", bank: bank ).persisted?
    end
end
