require 'test_helper'

class Internal::InstallerCertificationsInstallersControllerTest < ActionController::TestCase
  setup do
    @internal_installer_certifications_installer = internal_installer_certifications_installers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:internal_installer_certifications_installers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create internal_installer_certifications_installer" do
    assert_difference('Internal::InstallerCertificationsInstaller.count') do
      post :create, internal_installer_certifications_installer: {  }
    end

    assert_redirected_to internal_installer_certifications_installer_path(assigns(:internal_installer_certifications_installer))
  end

  test "should show internal_installer_certifications_installer" do
    get :show, id: @internal_installer_certifications_installer
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @internal_installer_certifications_installer
    assert_response :success
  end

  test "should update internal_installer_certifications_installer" do
    patch :update, id: @internal_installer_certifications_installer, internal_installer_certifications_installer: {  }
    assert_redirected_to internal_installer_certifications_installer_path(assigns(:internal_installer_certifications_installer))
  end

  test "should destroy internal_installer_certifications_installer" do
    assert_difference('Internal::InstallerCertificationsInstaller.count', -1) do
      delete :destroy, id: @internal_installer_certifications_installer
    end

    assert_redirected_to internal_installer_certifications_installers_path
  end
end
