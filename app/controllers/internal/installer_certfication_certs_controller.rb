class Internal::InstallerCertficationCertsController < ApplicationController
  before_action :set_internal_installer_certfication_cert, only: [:show, :edit, :update, :destroy]

  # GET /internal/installer_certfication_certs
  def index
    @internal_installer_certfication_certs = Internal::InstallerCertficationCert.all
  end

  # GET /internal/installer_certfication_certs/1
  def show
  end

  # GET /internal/installer_certfication_certs/new
  def new
    @internal_installer_certfication_cert = Internal::InstallerCertficationCert.new
  end

  # GET /internal/installer_certfication_certs/1/edit
  def edit
  end

  # POST /internal/installer_certfication_certs
  def create
    @internal_installer_certfication_cert = Internal::InstallerCertficationCert.new(internal_installer_certfication_cert_params)

    if @internal_installer_certfication_cert.save
      redirect_to @internal_installer_certfication_cert, notice: 'Installer certfication cert was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /internal/installer_certfication_certs/1
  def update
    if @internal_installer_certfication_cert.update(internal_installer_certfication_cert_params)
      redirect_to @internal_installer_certfication_cert, notice: 'Installer certfication cert was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /internal/installer_certfication_certs/1
  def destroy
    @internal_installer_certfication_cert.destroy
    redirect_to internal_installer_certfication_certs_url, notice: 'Installer certfication cert was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_internal_installer_certfication_cert
      @internal_installer_certfication_cert = Internal::InstallerCertficationCert.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def internal_installer_certfication_cert_params
      params[:internal_installer_certfication_cert]
    end
end
