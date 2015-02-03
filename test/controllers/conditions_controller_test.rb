require 'test_helper'

class ConditionsControllerTest < ActionController::TestCase
  setup do
    @condition = Condition.create(
      airline: Airline.first,
      start_date: Date.today(),
      end_date: Date.today()+30,
      legal_description: "Descripcion legal",
      promotions: [ Promotion.create( bin: "4656,3340", quota: "3 y 6", bank: Bank.create(name: "Galicia") , credit_card: CreditCard.create(name:"Visa", quantity_digits: 15, quantity_code_security: 3, bin_start: 4542) ), Promotion.create( bin: "4656,3340", quota: "3 y 6", bank: Bank.create(name: "City bank") ), Promotion.create( bin: "4656,3340", quota: "3 y 6", credit_card: CreditCard.create(name:"Amex", quantity_digits: 16, quantity_code_security: 4, bin_start: 4542) ) ]
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
      Promotion.create( bin: "4656,3340", quota: "3 y 6", bank: Bank.create(name: "Galicia") , credit_card: CreditCard.create(name:"Visa", quantity_digits: 15, quantity_code_security: 3, bin_start: 4542) ),
      Promotion.create( bin: "4656,3340", quota: "3 y 6", bank: Bank.create(name: "City bank") ),
      Promotion.create( bin: "4656,3340", quota: "3 y 6", credit_card: CreditCard.create(name:"Amex", quantity_digits: 16, quantity_code_security: 4, bin_start: 4542) )
    ]
    airline = Airline.first
    assert_difference('Condition.count') do
      post :create, condition: { airline: airline, start_date: Date.today() , end_date: Date.today()+40 ,  legal_description: "Descripcion legal", promotions: promotions }
    end
    assert_redirected_to condition_path(assigns(:condition))
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
    patch :update, id: @condition, condition: { end_date: @condition.end_date, legal_description: @condition.legal_description, start_date: @condition.start_date }
    assert_redirected_to condition_path(assigns(:condition))
  end

  test "should destroy condition" do
    assert_difference('Condition.count', -1) do
      delete :destroy, id: @condition
    end

    assert_redirected_to conditions_path
  end
end
