require 'test_helper'

class Internal::InstallerCertficationCertsControllerTest < ActionController::TestCase
  setup do
    @internal_installer_certfication_cert = internal_installer_certfication_certs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:internal_installer_certfication_certs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create internal_installer_certfication_cert" do
    assert_difference('Internal::InstallerCertficationCert.count') do
      post :create, internal_installer_certfication_cert: {  }
    end

    assert_redirected_to internal_installer_certfication_cert_path(assigns(:internal_installer_certfication_cert))
  end

  test "should show internal_installer_certfication_cert" do
    get :show, id: @internal_installer_certfication_cert
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @internal_installer_certfication_cert
    assert_response :success
  end

  test "should update internal_installer_certfication_cert" do
    patch :update, id: @internal_installer_certfication_cert, internal_installer_certfication_cert: {  }
    assert_redirected_to internal_installer_certfication_cert_path(assigns(:internal_installer_certfication_cert))
  end

  test "should destroy internal_installer_certfication_cert" do
    assert_difference('Internal::InstallerCertficationCert.count', -1) do
      delete :destroy, id: @internal_installer_certfication_cert
    end

    assert_redirected_to internal_installer_certfication_certs_path
  end
end
