class Teknion::ActionPlan < Teknion::Base

  attribute :actionplan_id, String
  attribute :issue_id, String
  attribute :incident_id, String
  attribute :reason_teknion, String
  attribute :reason_facility, String
  attribute :response_code, String
  attribute :comment, String
  attribute :actionplan_timestamp, String
  attribute :replaced_products, Array[Teknion::ActionPlanOrder]
  attribute :replaceorder_ponumber, String
  def self.find(claim_issue_id, dealer_code)
    response = client.get "tekcare/issues/#{claim_issue_id}/actionplandetail", {dealer_code: dealer_code}
    new(response.body)
  end
end

