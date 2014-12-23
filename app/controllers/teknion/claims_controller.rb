class Teknion::ClaimsController < ApplicationController
  before_action :set_claim, only: [:show, :cancel]
  before_action :set_claims, only: :index

  def index
  end

  def show
  end

  def cancel
    @claim.cancel
    redirect_to claims_path
  end

  private
    def set_claim
      
      dealer_code=session[:DealerCode]
      @claim = Teknion::Claim.find(params[:id], dealer_code)
    end

    def set_claims
        
      dealer_code=session[:DealerCode]
      @claims = Teknion::Claim.all("OPEN", dealer_code)
    end
end
