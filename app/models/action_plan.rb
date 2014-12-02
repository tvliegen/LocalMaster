class ActionPlan < ActiveRecord::Base
  belongs_to :claim_issue
  has_many :replacement_orders
end
