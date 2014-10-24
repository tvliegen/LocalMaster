class ClaimIssue < ActiveRecord::Base
  belongs_to :claim
  has_many :clarifications
end
