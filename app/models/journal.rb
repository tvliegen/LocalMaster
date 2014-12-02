class Journal < ActiveRecord::Base
  belongs_to :claim_issue
  has_many :journal_attachments

  accepts_nested_attributes_for :journal_attachments
end
