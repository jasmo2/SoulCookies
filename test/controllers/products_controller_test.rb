require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get add_to_basket" do
    get :add_to_basket
    assert_response :success
  end

end
