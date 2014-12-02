class Api::ClarificationsController < Api::ApiController
  before_action :set_clarification, only: [:show, :edit, :update, :destroy]

  respond_to :json

  def index
    @clarifications = ClaimIssue.find(params[:claim_issue_id]).clarifications.order(updated_at: :desc)
    render json: @clarifications
  end

  def show
    render json: @clarification
  end

  def new
    @clarification = Clarification.new
  end

  def update
    if @clarification.update(clarification_params)
      render nothing: true, status: :created
    else
      render json: @clarification.errors, status: :unprocessable_entity
    end
  end

  def create
    @clarification = Clarification.new(clarification_params)

    if @clarification.save
      render nothing: true, status: :created
    else
      render json: @clarification.errors, status: :unprocessable_entity
    end
  end

  private
    def set_clarification
      @clarification ||= Clarification.find(params[:id])
    end

    def clarification_params
      params.permit(:claim_issue_id, :subject, :question, :answer, :author)
    end
end

