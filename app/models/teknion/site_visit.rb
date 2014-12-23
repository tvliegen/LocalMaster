class Teknion::SiteVisit < Teknion::Base

  def self.all(claim_issue_id, dealer_code)
    response = client.get "tekcare/issues/#{claim_issue_id}/sitevisitlist", {dealer_code: dealer_code}
    return [] if response.body['sitevisits'].nil?

    response.body['sitevisits'].map {|item| new(item) }
  end

  def self.find(id, dealer_code)
    response = client.get "tekcare/sitevisits/#{id}/sitevisitdetail", {dealer_code: dealer_code}
    return [] if response.body['sitevisit'].nil?

    new(response.body['sitevisit'])
  end

end

