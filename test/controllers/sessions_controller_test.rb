require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get authenticate" do
    get :authenticate
    assert_response :success
  end

  test "should get fail" do
    get :fail
    assert_response :success
  end

  test "should get destroy" do
    get :destroy
    assert_response :success
  end

end
