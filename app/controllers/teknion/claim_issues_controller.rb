class Teknion::ClaimIssuesController < ApplicationController
  before_action :set_claim_issue

  def show
    @section = params[:section] if params[:section].present?
  end

  private
    def set_claim_issue
      # get claim_issue data
      claim_issue_response = tekcare_connection.get "tekcare/issues/#{params[:id]}/actionplandetail", {dealer_code: "200188"}
      claim_issue_data = claim_issue_response.body

      # get the claim again
      claim_response = tekcare_connection.get "tekcare/claims/#{claim_issue_response.body['incident_id']}/claimdetail", {dealer_code: "200188"}
      additional_claim_issue_data = claim_response.body['claim_issues'].select {|ci| ci['issue_id'] == params[:id] }.first
      merged_claim_issue_data = claim_issue_data.merge!(additional_claim_issue_data)

      @section = params[:section]
      if @section.nil? || @section == 'clarifications'
        clarifications_response = tekcare_connection.get "tekcare/claims/#{claim_issue_response.body['incident_id']}/clarificationlist", {dealer_code: "200188"}
        merged_claim_issue_data['clarifications'] = clarifications_response.body['clarifications']
      elsif @section == 'other_information'
        journal_response = tekcare_connection.get "tekcare/claims/#{claim_issue_response.body['incident_id']}/journallist", {dealer_code: "200188"}
        merged_claim_issue_data['journals'] = journal_response.body['journals']
      end
      @claim_issue = Teknion::ClaimIssue.new(merged_claim_issue_data)
    end
end

