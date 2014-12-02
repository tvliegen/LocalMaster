class Api::ClaimIssuesController < Api::ApiController
  before_action :set_claim, only: :index

  respond_to :json

  def index
    render json: @claim.claim_issues
  end

  def show
    logger.debug "(Api::ClaimIssuesController) #{params}"
    render json: ClaimIssue.find(params[:id])
  end

  private
    def set_claim
      @claim ||= Claim.find(params[:claim_id])
    end
end
