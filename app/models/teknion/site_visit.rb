class Teknion::SiteVisit < Teknion::Base

  attribute :issue_id, String
  attribute :sitevisit_id, String
  attribute :visit_reason, String
  attribute :issue_date, Date
  attribute :appointment_date, Date
  attribute :appointment_time, Time
  attribute :postvisit_date, Date
  attribute :resolution, String
  attribute :scheduled, String

  def save(dealer_code)
    client.put "tekcare/sitevisits/{issue_id}/sitevisitupdate", {dealer_code: dealer_code}
  end

  def self.all(claim_issue_id, dealer_code)
    response = client.get "tekcare/issues/#{claim_issue_id}/sitevisitlist", {dealer_code: dealer_code}
    return [] if response.body['sitevisits'].nil?

    response.body['sitevisits'].map {|item| new(item) }
  end

  def self.find(id, dealer_code)
    response = client.get "tekcare/sitevisits/#{id}/sitevisitdetail", {dealer_code: dealer_code}
    return nil if response.body.nil?

    new(response.body)
  end

end

