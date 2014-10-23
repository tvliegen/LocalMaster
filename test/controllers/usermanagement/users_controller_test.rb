require 'test_helper'

class Usermanagement::UsersControllerTest < ActionController::TestCase
  setup do
    @usermanagement_user = usermanagement_users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:usermanagement_users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create usermanagement_user" do
    assert_difference('Usermanagement::User.count') do
      post :create, usermanagement_user: {  }
    end

    assert_redirected_to usermanagement_user_path(assigns(:usermanagement_user))
  end

  test "should show usermanagement_user" do
    get :show, id: @usermanagement_user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @usermanagement_user
    assert_response :success
  end

  test "should update usermanagement_user" do
    patch :update, id: @usermanagement_user, usermanagement_user: {  }
    assert_redirected_to usermanagement_user_path(assigns(:usermanagement_user))
  end

  test "should destroy usermanagement_user" do
    assert_difference('Usermanagement::User.count', -1) do
      delete :destroy, id: @usermanagement_user
    end

    assert_redirected_to usermanagement_users_path
  end
end
