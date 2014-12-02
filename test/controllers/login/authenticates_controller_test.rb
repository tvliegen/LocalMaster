require 'test_helper'

class Login::AuthenticatesControllerTest < ActionController::TestCase
  setup do
    @login_authenticate = login_authenticates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:login_authenticates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create login_authenticate" do
    assert_difference('Login::Authenticate.count') do
      post :create, login_authenticate: {  }
    end

    assert_redirected_to login_authenticate_path(assigns(:login_authenticate))
  end

  test "should show login_authenticate" do
    get :show, id: @login_authenticate
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @login_authenticate
    assert_response :success
  end

  test "should update login_authenticate" do
    patch :update, id: @login_authenticate, login_authenticate: {  }
    assert_redirected_to login_authenticate_path(assigns(:login_authenticate))
  end

  test "should destroy login_authenticate" do
    assert_difference('Login::Authenticate.count', -1) do
      delete :destroy, id: @login_authenticate
    end

    assert_redirected_to login_authenticates_path
  end
end
