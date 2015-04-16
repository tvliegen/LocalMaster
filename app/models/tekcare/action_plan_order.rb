class Tekcare::ActionPlanOrder
  include ActiveModel::Model
  include Virtus.model
  include HTTParty

  attribute :replaceproduct_id, String
  attribute :seqno, String
  attribute :product_code, String
  attribute :sq_number, String
  attribute :qty_ordered, String
  attribute :cr_number, String
  attribute :product_description, String
  
end
