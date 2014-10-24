class Claim < ActiveRecord::Base
  has_many :claim_issues

  scope :active, -> { where('"status" <> \'closed\'') }
end
