class Teknion::ActionPlanController < ApplicationController
  before_action :set_action_plan, only: [:show, :edit, :update, :destroy]

  def index
    @action_plan = Teknion::ClaimIssue.find(params[:claim_issue_id]).action_plan
  end

  def show
  end

  def edit
    render :edit, layout: false
  end

  def new
    @action_plan = Teknion::ClaimIssue.find(params[:claim_issue_id]).build_action_plan
  end

  def create
    @action_plan = Teknion::ClaimIssue.find(params[:claim_issue_id]).build_action_plan(action_plan_params)

    if @action_plan.valid? && @action_plan.save
      flash[:notice] = 'Action Plan was successfully updated.'
      render inline: "<script> window.location.href = '#{teknion_claim_issue_path(@action_plan.claim_issue_id, section: :action_plan)}'; </script>"
    else
      render :new, layout: false
    end
  end

  def update
    @action_plan.assign_attributes(action_plan_params)

    if @action_plan.valid? && @action_plan.save
      flash[:notice] = 'Action Plan was successfully updated.'
      render inline: "<script> window.location.href = '#{teknion_claim_issue_path(@action_plan.claim_issue_id, section: :action_plan)}'; </script>"
    else
      render :edit, layout: false
    end
  end

  def destroy
  end

  private
    def set_action_plan
     @action_plan ||= Teknion::ActionPlan.find(params[:id])
    end

    def action_plan_params
      params.require(:teknion_action_plan).permit(:author, :action, :text)
    end
end
