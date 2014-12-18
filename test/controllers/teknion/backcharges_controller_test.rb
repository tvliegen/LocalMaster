require 'test_helper'

class Teknion::BackchargesControllerTest < ActionController::TestCase
  setup do
    @teknion_backcharge = teknion_backcharges(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:teknion_backcharges)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create teknion_backcharge" do
    assert_difference('Teknion::Backcharge.count') do
      post :create, teknion_backcharge: {  }
    end

    assert_redirected_to teknion_backcharge_path(assigns(:teknion_backcharge))
  end

  test "should show teknion_backcharge" do
    get :show, id: @teknion_backcharge
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @teknion_backcharge
    assert_response :success
  end

  test "should update teknion_backcharge" do
    patch :update, id: @teknion_backcharge, teknion_backcharge: {  }
    assert_redirected_to teknion_backcharge_path(assigns(:teknion_backcharge))
  end

  test "should destroy teknion_backcharge" do
    assert_difference('Teknion::Backcharge.count', -1) do
      delete :destroy, id: @teknion_backcharge
    end

    assert_redirected_to teknion_backcharges_path
  end
end
