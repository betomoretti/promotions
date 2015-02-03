require 'test_helper'

class PromotionsControllerTest < ActionController::TestCase
  setup do
    @promotion = Promotion.create(quota: "3, 6, y 12", bin: "2312,3434,2345", bank: Bank.create(name: "Galicia"), credit_card: CreditCard.create(name:"Visa", quantity_digits: 15, quantity_code_security: 3, bin_start: 4542) )
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:promotions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create promotion" do
    assert_difference('Promotion.count') do
      post :create, promotion: { bin: 4656, quota: "3 y 6", bank: Bank.create(name: "Galicia") , credit_card: CreditCard.create(name:"Visa", quantity_digits: 15, quantity_code_security: 3, bin_start: 4542) }
    end

    assert_redirected_to promotion_path(assigns(:promotion))
  end

  test "should show promotion" do
    get :show, id: @promotion
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @promotion
    assert_response :success
  end

  test "should update promotion" do
    patch :update, id: @promotion, promotion: { bin: "2354, 3562, 3562", quota: "3" }
    assert_redirected_to promotion_path(assigns(:promotion))
  end

  test "should destroy promotion" do
    assert_difference('Promotion.count', -1) do
      delete :destroy, id: @promotion
    end

    assert_redirected_to promotions_path
  end
end
