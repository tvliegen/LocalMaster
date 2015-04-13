class Internal::InstallersCertificationsController < ApplicationController
  before_action :set_internal_installers_certification, only: [:show, :edit, :update, :destroy]

  # GET /internal/installers_certifications
  def index
    @internal_installers_certifications = Internal::InstallersCertification.all
  end

  # GET /internal/installers_certifications/1
  def show
  end

  # GET /internal/installers_certifications/new
  def new
    @internal_installers_certification = Internal::InstallersCertification.new
  end

  # GET /internal/installers_certifications/1/edit
  def edit
  end

  # POST /internal/installers_certifications
  def create
    @internal_installers_certification = Internal::InstallersCertification.new(internal_installers_certification_params)

    if @internal_installers_certification.save
      redirect_to @internal_installers_certification, notice: 'Installers certification was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /internal/installers_certifications/1
  def update
    if @internal_installers_certification.update(internal_installers_certification_params)
      redirect_to @internal_installers_certification, notice: 'Installers certification was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /internal/installers_certifications/1
  def destroy
    @internal_installers_certification.destroy
    redirect_to internal_installers_certifications_url, notice: 'Installers certification was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_internal_installers_certification
      @internal_installers_certification = Internal::InstallersCertification.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def internal_installers_certification_params
      params[:internal_installers_certification]
    end
end
