class Teknion::BackChargeIds < Teknion::Base

   attribute :issue_list, Array
   def self.find(claim_issue_id, dealer_code)
    response = client.get "/tekcare/issues/2015/issuelist?dealer_code=190017", {dealer_code: dealer_code}
    new(response.body)
  end
end

