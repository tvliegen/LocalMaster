class Internal::InstallerCertificationsInstallersController < ApplicationController
  before_action :set_internal_installer_certifications_installer, only: [:show, :edit, :update, :destroy]

  # GET /internal/installer_certifications_installers
  def index
    @internal_installer_certifications_installers = Internal::InstallerCertificationsInstaller.all
  end

  # GET /internal/installer_certifications_installers/1
  def show
  end

  # GET /internal/installer_certifications_installers/new
  def new
    @internal_installer_certifications_installer = Internal::InstallerCertificationsInstaller.new
    @internal_installer_certifications_installer.companyid=params['companyid']
  end

  # GET /internal/installer_certifications_installers/1/edit
  def edit
  end

  # POST /internal/installer_certifications_installers
  def create
    @internal_installer_certifications_installer = Internal::InstallerCertificationsInstaller.new(internal_installer_certifications_installer_params)
    
    if @internal_installer_certifications_installer.save
      redirect_to @internal_installer_certifications_installer, notice: 'Installer certifications installer was successfully created.'
    else
      render :new
    end
   
  end

  # PATCH/PUT /internal/installer_certifications_installers/1
  def update
    if @internal_installer_certifications_installer.update(internal_installer_certifications_installer_params)
      redirect_to @internal_installer_certifications_installer, notice: 'Installer certifications installer was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /internal/installer_certifications_installers/1
  def destroy
    @internal_installer_certifications_installer.destroy
    redirect_to internal_installer_certifications_installers_url, notice: 'Installer certifications installer was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_internal_installer_certifications_installer
      @internal_installer_certifications_installer = Internal::InstallerCertificationsInstaller.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def internal_installer_certifications_installer_params
      params.permit(:installername, :installercontactnumber, :installercontactemail, :companyid)
    end
end
