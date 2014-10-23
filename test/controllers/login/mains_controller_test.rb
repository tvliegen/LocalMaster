require 'test_helper'

class Login::MainsControllerTest < ActionController::TestCase
  setup do
    @login_main = login_mains(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:login_mains)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create login_main" do
    assert_difference('Login::Main.count') do
      post :create, login_main: {  }
    end

    assert_redirected_to login_main_path(assigns(:login_main))
  end

  test "should show login_main" do
    get :show, id: @login_main
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @login_main
    assert_response :success
  end

  test "should update login_main" do
    patch :update, id: @login_main, login_main: {  }
    assert_redirected_to login_main_path(assigns(:login_main))
  end

  test "should destroy login_main" do
    assert_difference('Login::Main.count', -1) do
      delete :destroy, id: @login_main
    end

    assert_redirected_to login_mains_path
  end
end
