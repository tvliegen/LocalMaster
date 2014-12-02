class Api::ActionPlanController < Api::ApiController
  before_action :set_action_plan, only: [:show, :edit, :update, :destroy]

  respond_to :json

  def index
    @action_plan = ClaimIssue.find(params[:claim_issue_id]).action_plan
    render json: @action_plan
  end

  def show
    render json: @action_plan
  end

  def new
    @action_plan = ActionPlan.new
  end

  def create
    @action_plan = ActionPlan.new(action_plan_params)

    if @action_plan.save
      render nothing: true, status: :created
    else
      render json: @action_plan.errors, status: :unprocessable_entity
    end
  end

  def update
    if @action_plan.update(action_plan_params)
      render nothing: true, status: :created
    else
      render json: @action_plan.errors, status: :unprocessable_entity
    end
  end

  private
    def set_action_plan
      @action_plan = ActionPlan.find(params[:id])
    end

    def action_plan_params
      params.require(:action_plan).permit(:claim_issue_id, :action, :author, :text)
    end
end
