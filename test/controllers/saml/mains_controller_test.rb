require 'test_helper'

class Saml::MainsControllerTest < ActionController::TestCase
  setup do
    @saml_main = saml_mains(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:saml_mains)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create saml_main" do
    assert_difference('Saml::Main.count') do
      post :create, saml_main: {  }
    end

    assert_redirected_to saml_main_path(assigns(:saml_main))
  end

  test "should show saml_main" do
    get :show, id: @saml_main
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @saml_main
    assert_response :success
  end

  test "should update saml_main" do
    patch :update, id: @saml_main, saml_main: {  }
    assert_redirected_to saml_main_path(assigns(:saml_main))
  end

  test "should destroy saml_main" do
    assert_difference('Saml::Main.count', -1) do
      delete :destroy, id: @saml_main
    end

    assert_redirected_to saml_mains_path
  end
end
