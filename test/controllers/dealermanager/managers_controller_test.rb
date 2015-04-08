require 'test_helper'

class Dealermanager::ManagersControllerTest < ActionController::TestCase
  setup do
    @dealermanager_manager = dealermanager_managers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:dealermanager_managers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create dealermanager_manager" do
    assert_difference('Dealermanager::Manager.count') do
      post :create, dealermanager_manager: {  }
    end

    assert_redirected_to dealermanager_manager_path(assigns(:dealermanager_manager))
  end

  test "should show dealermanager_manager" do
    get :show, id: @dealermanager_manager
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @dealermanager_manager
    assert_response :success
  end

  test "should update dealermanager_manager" do
    patch :update, id: @dealermanager_manager, dealermanager_manager: {  }
    assert_redirected_to dealermanager_manager_path(assigns(:dealermanager_manager))
  end

  test "should destroy dealermanager_manager" do
    assert_difference('Dealermanager::Manager.count', -1) do
      delete :destroy, id: @dealermanager_manager
    end

    assert_redirected_to dealermanager_managers_path
  end
end
