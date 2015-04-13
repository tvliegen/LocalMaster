require 'test_helper'

class Internal::InstallersCertificationsControllerTest < ActionController::TestCase
  setup do
    @internal_installers_certification = internal_installers_certifications(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:internal_installers_certifications)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create internal_installers_certification" do
    assert_difference('Internal::InstallersCertification.count') do
      post :create, internal_installers_certification: {  }
    end

    assert_redirected_to internal_installers_certification_path(assigns(:internal_installers_certification))
  end

  test "should show internal_installers_certification" do
    get :show, id: @internal_installers_certification
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @internal_installers_certification
    assert_response :success
  end

  test "should update internal_installers_certification" do
    patch :update, id: @internal_installers_certification, internal_installers_certification: {  }
    assert_redirected_to internal_installers_certification_path(assigns(:internal_installers_certification))
  end

  test "should destroy internal_installers_certification" do
    assert_difference('Internal::InstallersCertification.count', -1) do
      delete :destroy, id: @internal_installers_certification
    end

    assert_redirected_to internal_installers_certifications_path
  end
end
