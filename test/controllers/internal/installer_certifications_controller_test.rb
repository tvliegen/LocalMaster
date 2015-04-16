require 'test_helper'

class Internal::InstallerCertificationsControllerTest < ActionController::TestCase
  setup do
    @internal_installer_certification = internal_installer_certifications(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:internal_installer_certifications)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create internal_installer_certification" do
    assert_difference('Internal::InstallerCertification.count') do
      post :create, internal_installer_certification: {  }
    end

    assert_redirected_to internal_installer_certification_path(assigns(:internal_installer_certification))
  end

  test "should show internal_installer_certification" do
    get :show, id: @internal_installer_certification
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @internal_installer_certification
    assert_response :success
  end

  test "should update internal_installer_certification" do
    patch :update, id: @internal_installer_certification, internal_installer_certification: {  }
    assert_redirected_to internal_installer_certification_path(assigns(:internal_installer_certification))
  end

  test "should destroy internal_installer_certification" do
    assert_difference('Internal::InstallerCertification.count', -1) do
      delete :destroy, id: @internal_installer_certification
    end

    assert_redirected_to internal_installer_certifications_path
  end
end
