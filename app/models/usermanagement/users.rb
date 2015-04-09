class Usermanagement::Users < ActiveRecord::Base

   def self.all(group_name)
    group=Idp::User.find_group(group_name)
    response =  Idp::User.get_group_members(group[0]['id'])
    return [] if response.nil?
    response
  end

  def self.find(id, dealer_code)
 #   response = client.get "tekcare/backcharges/#{id}/backchargedetail", {dealer_code: dealer_code}
  #  return nil if response.body.nil?

   # new(response.body)
  end

end
