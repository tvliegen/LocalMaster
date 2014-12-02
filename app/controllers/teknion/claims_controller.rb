class Teknion::ClaimsController < ApplicationController
  before_action :set_claim, only: [:show, :cancel]
  
  def index
    if params[:status].present?
      @claims = Teknion::Claim.where(status: params[:status])
    else
      @claims = Teknion::Claim.all
    end
  end

  def show
  end

  def cancel
    @claim.cancel
    redirect_to claims_path
  end

  private
    def set_claim
      @claim = Teknion::Claim.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    #def claim_params
      #params[:claim].permit(:tekcare_number, :title, :project, :created_by, :status)
    #end
end
