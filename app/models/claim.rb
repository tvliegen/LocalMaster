class Claim < ActiveRecord::Base
  validates :tekcare_number, :title, :project, :created_by, :status, presence: true
end
