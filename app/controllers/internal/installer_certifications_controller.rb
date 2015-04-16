class Internal::InstallerCertificationsController < ApplicationController
  before_action :set_internal_installer_certification, only: [:show, :edit, :update, :destroy]

  # GET /internal/installer_certifications
  def index
    @internal_installer_certifications = Internal::InstallerCertification.all
  end

  # GET /internal/installer_certifications/1
  def show
  end

  # GET /internal/installer_certifications/new
  def new
    @internal_installer_certification = Internal::InstallerCertification.new
  end

  # GET /internal/installer_certifications/1/edit
  def edit
  end

  # POST /internal/installer_certifications
  def create
    @internal_installer_certification = Internal::InstallerCertification.new(internal_installer_certification_params)
 
    if @internal_installer_certification.save
      redirect_to internal_installer_certifications_path
    else
      render :new
    end
  end

  # PATCH/PUT /internal/installer_certifications/1
  def update
    if @internal_installer_certification.update(internal_installer_certification_params)
      redirect_to @internal_installer_certification, notice: 'Installer certification was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /internal/installer_certifications/1
  def destroy
    @internal_installer_certification.destroy
    redirect_to internal_installer_certifications_url, notice: 'Installer certification was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_internal_installer_certification
      @internal_installer_certification = Internal::InstallerCertification.find(params[:id])
     @internal_installer_certification_installers = Internal::InstallerCertificationsInstaller.where(companyid: @internal_installer_certification.id)

    end

    # Only allow a trusted parameter "white list" through.
    def internal_installer_certification_params
      params.permit(:companyname, :companyaddress, :companycity, :companyprovstate, :companypostalzip, :companycountry, :companycontactname, :companycontactnumber,:companycontactemail, :companydealers,:companycomments,:companyprojects)
    end
end
