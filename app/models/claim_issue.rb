class ClaimIssue < ActiveRecord::Base
  belongs_to :claim
  has_many :clarifications
  has_many :journals
  has_many :site_visits
  has_one  :action_plan
end
