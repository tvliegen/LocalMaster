class Api::ClaimsController < Api::ApiController
  before_action :set_claim, only: :show

  respond_to :json

  def index
    claims = if params[:status].present?
               Claim.where(status: params[:status])
             else
               Claim.active
             end

    render json: claims
  end

  def show
    render json: @claim
  end

  def cancel
    render nothing: true, status: :ok
  end

  private
    def set_claim
      @claim = Claim.find(params[:id])
    end
end

