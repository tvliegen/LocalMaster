class Teknion::ClarificationsController < ApplicationController
  before_action :set_clarification, only: [:show, :edit, :update, :destroy]

  def index
    @clarifications = Teknion::ClaimIssue.find(params[:claim_issue_id]).clarifications
  end

  def show
  end

  def edit
    render :edit, layout: false
  end

  def new
    @clarification = Teknion::ClaimIssue.find(params[:claim_issue_id]).clarifications.build
  end

  def create
    @clarification = Teknion::ClaimIssue.find(params[:claim_issue_id]).clarifications.build(clarification_params)

    if @clarification.valid? && @clarification.save
      flash[:notice] = 'Clarification was successfully updated.'
      render inline: "<script> window.location.href = '#{teknion_claim_issue_path(@clarification.claim_issue_id)}'; </script>"
    else
      render :new, layout: false
    end
  end

  def update
    @clarification.assign_attributes(clarification_params)

    if @clarification.valid? && @clarification.save
      flash[:notice] = 'Clarification was successfully updated.'
      render inline: "<script> window.location.href = '#{teknion_claim_issue_path(@clarification.claim_issue_id)}'; </script>"
    else
      render :edit, layout: false
    end
  end

  def destroy
  end

  private
    def set_clarification
      clarifications_response = tekcare_connection.get "tekcare/issues/#{params[:claim_issue_id]}/clarificationlist", {dealer_code: "200188"}
      clarification_data = clarifications_response.body['clarifications'].select {|cl| cl['clarification_id'] == params[:id] }.first
      @clarification = Teknion::Clarification.new(clarification_data)
    end

    def clarification_params
      params.require(:teknion_clarification).permit(:claim_issue_id, :subject, :question, :answer, :author)
    end
end
