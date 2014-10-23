require 'test_helper'

class Portalmanager::MainsControllerTest < ActionController::TestCase
  setup do
    @portalmanager_main = portalmanager_mains(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:portalmanager_mains)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create portalmanager_main" do
    assert_difference('Portalmanager::Main.count') do
      post :create, portalmanager_main: {  }
    end

    assert_redirected_to portalmanager_main_path(assigns(:portalmanager_main))
  end

  test "should show portalmanager_main" do
    get :show, id: @portalmanager_main
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @portalmanager_main
    assert_response :success
  end

  test "should update portalmanager_main" do
    patch :update, id: @portalmanager_main, portalmanager_main: {  }
    assert_redirected_to portalmanager_main_path(assigns(:portalmanager_main))
  end

  test "should destroy portalmanager_main" do
    assert_difference('Portalmanager::Main.count', -1) do
      delete :destroy, id: @portalmanager_main
    end

    assert_redirected_to portalmanager_mains_path
  end
end
