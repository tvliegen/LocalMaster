class Teknion::Claim
  include Her::Model

  #def cancel
    #self.delete(:cancel)
  #end

  has_many :claim_issues, class_name: "Teknion::ClaimIssue"
end
