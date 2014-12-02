class JournalAttachment < ActiveRecord::Base
  belongs_to :journal
  has_attached_file :attachment
  validates_attachment_content_type :attachment, :content_type => [/\Aimage\/.*\Z/, 'application/octet-stream']

end
