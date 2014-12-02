class Teknion::ClaimIssuesController < ApplicationController
  before_action :set_claim_issue

  def show
    @section = params[:section] if params[:section].present?
  end

  private
    def set_claim_issue
      @claim_issue ||= Teknion::ClaimIssue.find(params[:id])
    end
end

