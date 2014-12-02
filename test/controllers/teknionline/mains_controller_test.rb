require 'test_helper'

class Teknionline::MainsControllerTest < ActionController::TestCase
  setup do
    @teknionline_main = teknionline_mains(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:teknionline_mains)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create teknionline_main" do
    assert_difference('Teknionline::Main.count') do
      post :create, teknionline_main: {  }
    end

    assert_redirected_to teknionline_main_path(assigns(:teknionline_main))
  end

  test "should show teknionline_main" do
    get :show, id: @teknionline_main
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @teknionline_main
    assert_response :success
  end

  test "should update teknionline_main" do
    patch :update, id: @teknionline_main, teknionline_main: {  }
    assert_redirected_to teknionline_main_path(assigns(:teknionline_main))
  end

  test "should destroy teknionline_main" do
    assert_difference('Teknionline::Main.count', -1) do
      delete :destroy, id: @teknionline_main
    end

    assert_redirected_to teknionline_mains_path
  end
end
