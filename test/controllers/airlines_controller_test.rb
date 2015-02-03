require 'test_helper'

class AirlinesControllerTest < ActionController::TestCase

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:airlines)
  end

end
