require 'test_helper'

class Internal::MassmailsControllerTest < ActionController::TestCase
  setup do
    @internal_massmail = internal_massmails(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:internal_massmails)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create internal_massmail" do
    assert_difference('Internal::Massmail.count') do
      post :create, internal_massmail: {  }
    end

    assert_redirected_to internal_massmail_path(assigns(:internal_massmail))
  end

  test "should show internal_massmail" do
    get :show, id: @internal_massmail
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @internal_massmail
    assert_response :success
  end

  test "should update internal_massmail" do
    patch :update, id: @internal_massmail, internal_massmail: {  }
    assert_redirected_to internal_massmail_path(assigns(:internal_massmail))
  end

  test "should destroy internal_massmail" do
    assert_difference('Internal::Massmail.count', -1) do
      delete :destroy, id: @internal_massmail
    end

    assert_redirected_to internal_massmails_path
  end
end
