require 'test_helper'

class Teknionline::ProfilesControllerTest < ActionController::TestCase
  setup do
    @teknionline_profile = teknionline_profiles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:teknionline_profiles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create teknionline_profile" do
    assert_difference('Teknionline::Profile.count') do
      post :create, teknionline_profile: {  }
    end

    assert_redirected_to teknionline_profile_path(assigns(:teknionline_profile))
  end

  test "should show teknionline_profile" do
    get :show, id: @teknionline_profile
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @teknionline_profile
    assert_response :success
  end

  test "should update teknionline_profile" do
    patch :update, id: @teknionline_profile, teknionline_profile: {  }
    assert_redirected_to teknionline_profile_path(assigns(:teknionline_profile))
  end

  test "should destroy teknionline_profile" do
    assert_difference('Teknionline::Profile.count', -1) do
      delete :destroy, id: @teknionline_profile
    end

    assert_redirected_to teknionline_profiles_path
  end
end
