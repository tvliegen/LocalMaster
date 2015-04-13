class Teknion::SiteVisitsController < ApplicationController
  before_action :set_site_visit, only: [:show, :edit, :update]

  def show
  end

  def edit
    @claim_id=params[:claim_id]
    @issue_id=params[:claim_issue_id]
    render :edit, layout: false
  end

  def update
   
    site_visit_info=Hash.new
    site_visit_info['appointment_date']=Date.civil(*params[:appointment_date].sort.map(&:last).map(&:to_i))
    site_visit_info['appointment_time']=Time.parse(params[:appointment_time]['appointment_time(4i)']+":"+params[:appointment_time]['appointment_time(5i)']).strftime("%H:%M:%S")
    site_visit_info['site_contact_name']=params['site_visit_Contact_Name']
    site_visit_info['site_contact_number']=params['site_visit_Contact_Number']
    site_visit_info['site_contact_email']=params['site_visit_Contact_Email']
    dealer_code=session[:DealerCode]


    if @site_visit.valid?
      sitevisit_response = tekcare_connection.put do |req|
        req.url "tekcare/sitevisits/#{params[:id]}?dealer_code=#{dealer_code}&action=schedule"
        req.headers['Content-Type'] = 'application/json'
        req.body = site_visit_info.to_json
      end
    end
      if sitevisit_response.status == 201
        flash[:notice] = 'Site Visit was successfully updated.'
      else
        flash[:notice] = 'There was a problem creating your Site Visit.'
      end

  
     render inline: "<script> window.location.href = '#{teknion_claim_issue_path(params[:issue_id], section: :site_visit, claim_id: params[:claim_id])}'; </script>"
    end

  private
    def set_site_visit
      @site_visit = Teknion::SiteVisit.find(params[:id], session['DealerCode'])
    end

    def site_visit_params
      params.require(:teknion_site_visit).permit(:claim_issue_id, :appointment_date, :appointment_time, :author, :confirmed_by, :site_visit_name)
    end
end
