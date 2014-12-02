class Api::ReplacementOrdersController < Api::ApiController

  def index
    @replacement_orders = ActionPlan.find(params[:action_plan_id]).replacement_orders
    render json: @replacement_orders
  end

end
