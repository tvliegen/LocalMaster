class Teknion::RGADetail < Teknion::Base

  attribute :rga_id, String
  attribute :rga_products, Hash
  attribute :rga_pickup_info, Hash
  attribute :code, String

  def self.find(rgaid, dealer_code)
    response = client.get "tekcare/rgas/#{rgaid}/rgadetail", {dealer_code: dealer_code}
   
   return   response
   

  end



end
