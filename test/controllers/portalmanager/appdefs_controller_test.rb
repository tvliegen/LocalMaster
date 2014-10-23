require 'test_helper'

class Portalmanager::AppdefsControllerTest < ActionController::TestCase
  setup do
    @portalmanager_appdef = portalmanager_appdefs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:portalmanager_appdefs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create portalmanager_appdef" do
    assert_difference('Portalmanager::Appdef.count') do
      post :create, portalmanager_appdef: {  }
    end

    assert_redirected_to portalmanager_appdef_path(assigns(:portalmanager_appdef))
  end

  test "should show portalmanager_appdef" do
    get :show, id: @portalmanager_appdef
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @portalmanager_appdef
    assert_response :success
  end

  test "should update portalmanager_appdef" do
    patch :update, id: @portalmanager_appdef, portalmanager_appdef: {  }
    assert_redirected_to portalmanager_appdef_path(assigns(:portalmanager_appdef))
  end

  test "should destroy portalmanager_appdef" do
    assert_difference('Portalmanager::Appdef.count', -1) do
      delete :destroy, id: @portalmanager_appdef
    end

    assert_redirected_to portalmanager_appdefs_path
  end
end
