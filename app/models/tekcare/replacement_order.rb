class Tekcare::ReplacementOrder < Tekcare::Base

  attribute :order_header, Hash
  attribute :ship_header, Hash
  attribute :order_lines, Array[Hash]
  
  
  def self.find(po_number, dealer_code)
    response = client.get "/tekcare/orders/#{po_number}/orderdetail", {dealer_code: dealer_code, type: 'p'}
    new(response.body)
  end
end

