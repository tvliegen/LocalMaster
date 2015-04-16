require 'test_helper'

class Internal::InstallersCertifications::InstallersControllerTest < ActionController::TestCase
  setup do
    @internal_installers_certifications_installer = internal_installers_certifications_installers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:internal_installers_certifications_installers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create internal_installers_certifications_installer" do
    assert_difference('Internal::InstallersCertifications::Installer.count') do
      post :create, internal_installers_certifications_installer: {  }
    end

    assert_redirected_to internal_installers_certifications_installer_path(assigns(:internal_installers_certifications_installer))
  end

  test "should show internal_installers_certifications_installer" do
    get :show, id: @internal_installers_certifications_installer
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @internal_installers_certifications_installer
    assert_response :success
  end

  test "should update internal_installers_certifications_installer" do
    patch :update, id: @internal_installers_certifications_installer, internal_installers_certifications_installer: {  }
    assert_redirected_to internal_installers_certifications_installer_path(assigns(:internal_installers_certifications_installer))
  end

  test "should destroy internal_installers_certifications_installer" do
    assert_difference('Internal::InstallersCertifications::Installer.count', -1) do
      delete :destroy, id: @internal_installers_certifications_installer
    end

    assert_redirected_to internal_installers_certifications_installers_path
  end
end
