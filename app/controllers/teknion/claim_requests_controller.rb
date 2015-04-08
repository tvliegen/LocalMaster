class Teknion::ClaimRequestsController < ApplicationController
  
  def index
    dealer_code=session[:DealerCode]
   
      all_claims=Teknion::Claim.all('OPEN', dealer_code)
	@total_count=all_claims.count
	@info_count=all_claims.select {|i| i.status_type == 'info' }.count
	@action_count=all_claims.select {|i| i.status_type == 'actioned' }.count
	
	@claims=Teknion::Claim.closed(dealer_code)
	@close_count=@claims.count
      
  end
end
