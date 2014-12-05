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
      json_response = tekcare_connection.get "tekcare/claims/#{params[:id]}/claimdetail", {dealer_code: "190017"}
      return if json_response.body.nil?

      @claim = Teknion::Claim.new(json_response.body)
    end

    def set_claims
      @claims = []
      json_response = tekcare_connection.get "tekcare/claims/OPEN/listbystatus", {dealer_code: "190017"}
      return if json_response.body['claims'].nil?

      @claims = json_response.body['claims'].map {|claim| Teknion::Claim.new(claim) }
    end
end
