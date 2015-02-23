require 'test_helper'

class ConditionsControllerTest < ActionController::TestCase
  setup do
    @condition = Condition.create(
      airline: Airline.first,
      start_date: Date.today(),
      end_date: Date.today()+30,
      legal_description: "Descripcion legal",
      promotions: [ Promotion.create( bin: "4656,3340", quota: "3 y 6", start_date: Date.today() , end_date: Date.today()+40, bank: Bank.create(name: "Galicia") , credit_card: CreditCard.create(name:"Visa", quantity_digits: 15, quantity_code_security: 3, bin_start: 4542) ), Promotion.create( bin: "4656,3340", quota: "3 y 6", start_date: Date.today() , end_date: Date.today()+40, bank: Bank.create(name: "City bank") ), Promotion.create( bin: "4656,3340", quota: "3 y 6", start_date: Date.today() , end_date: Date.today()+40, credit_card: CreditCard.create(name:"Amex", quantity_digits: 16, quantity_code_security: 4, bin_start: 4542) ) ]
      )
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:conditions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create condition" do
    promotions = [
      Promotion.create( bin: "4656,3340", quota: "3 y 6", start_date: Date.today() , end_date: Date.today()+40 , bank: Bank.create(name: "Galicia") , credit_card: CreditCard.create(name:"Visa", quantity_digits: 15, quantity_code_security: 3, bin_start: 4542) ).id,
      Promotion.create( bin: "4656,3340", quota: "3 y 6", start_date: Date.today() , end_date: Date.today()+40 , bank: Bank.create(name: "City bank") ).id,
      Promotion.create( bin: "4656,3340", quota: "3 y 6", start_date: Date.today() , end_date: Date.today()+40 , credit_card: CreditCard.create(name:"Amex", quantity_digits: 16, quantity_code_security: 4, bin_start: 4542) ).id
    ]
    airline_id = Airline.first.id
    assert_difference('Condition.count') do
      condition = Condition.new
      condition.save(:validate => false)
      post :create, condition: {id: condition.id,airline: airline_id, start_date: Date.today() , end_date: Date.today()+40 ,  legal_description: "Descripcion legal", promotions: promotions }
    end
    assert_redirected_to condition_path(assigns(:condition))
  end

  test "shouldn't create condition without promotions" do
    promotions = []
    airline_id = Airline.first.id
    condition = Condition.new
    condition.save(:validate => false)
    post :create, condition: {id: condition.id,airline: airline_id, start_date: Date.today() , end_date: Date.today()+40 ,  legal_description: "Descripcion legal", promotions: promotions }
    assert_template("conditions/new")
  end

  test "shouldn't create condition without dates" do
    promotions = [
      Promotion.create( bin: "4656,3340", quota: "3 y 6", start_date: Date.today() , end_date: Date.today()+40 , bank: Bank.create(name: "Galicia") , credit_card: CreditCard.create(name:"Visa", quantity_digits: 15, quantity_code_security: 3, bin_start: 4542) ).id,
      Promotion.create( bin: "4656,3340", quota: "3 y 6", start_date: Date.today() , end_date: Date.today()+40 , bank: Bank.create(name: "City bank") ).id,
      Promotion.create( bin: "4656,3340", quota: "3 y 6", start_date: Date.today() , end_date: Date.today()+40 , credit_card: CreditCard.create(name:"Amex", quantity_digits: 16, quantity_code_security: 4, bin_start: 4542) ).id
    ]
    airline_id = Airline.first.id
    assert_difference('Condition.count') do
      condition = Condition.new
      condition.save(:validate => false)
      post :create, condition: {id: condition.id,airline: airline_id, start_date: nil , end_date: nil ,  legal_description: "Descripcion legal", promotions: promotions }
    end
    assert_template("conditions/new")
  end

  test "should show condition" do
    get :show, id: @condition
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @condition
    assert_response :success
  end

  test "should update condition" do
    promotions = [
      Promotion.create( bin: "4656,3340", quota: "3 y 6", start_date: Date.today() , end_date: Date.today()+40 , bank: Bank.create(name: "Galicia") , credit_card: CreditCard.create(name:"Visa", quantity_digits: 15, quantity_code_security: 3, bin_start: 4542) ).id,
      Promotion.create( bin: "4656,3340", quota: "3 y 6", start_date: Date.today() , end_date: Date.today()+40 , bank: Bank.create(name: "City bank") ).id,
    ]
    airline_id = Airline.last.id
    assert_difference('Promotion.count', -1) do #Chequea que le quite una promocion a la condicion
      patch :update, id: @condition, condition: { id: @condition.id ,airline: airline_id, end_date: @condition.end_date, legal_description: @condition.legal_description, start_date: @condition.start_date,  legal_description: "Descripcion legal", promotions: promotions }
    end
    
    assert_redirected_to condition_path(assigns(:condition))
  end

  test "should destroy condition" do
    assert_difference('Condition.count', -1) do
      delete :destroy, id: @condition
    end

    assert_redirected_to conditions_path
  end
end
