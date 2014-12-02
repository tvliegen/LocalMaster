class Teknion::SiteVisitsController < ApplicationController
  before_action :set_site_visit, only: [:show, :edit, :update, :destroy]

  def index
    @site_visits = Teknion::ClaimIssue.find(params[:claim_issue_id]).site_visits
  end

  def show
  end

  def edit
    render :edit, layout: false
  end

  def new
    @site_visit = Teknion::ClaimIssue.find(params[:claim_issue_id]).site_visits.build
  end

  def create
    @site_visit = Teknion::ClaimIssue.find(params[:claim_issue_id]).site_visits.build(site_visit_params)

    if @site_visit.valid? && @site_visit.save
      flash[:notice] = 'Site Visit was successfully updated.'
      render inline: "<script> window.location.href = '#{teknion_claim_issue_path(@site_visit.claim_issue_id, section: :site_visit)}'; </script>"
    else
      render :new, layout: false
    end
  end

  def update
    @site_visit.assign_attributes(site_visit_params)

    if @site_visit.valid? && @site_visit.save
      flash[:notice] = 'Site Visit was successfully updated.'
      render inline: "<script> window.location.href = '#{teknion_claim_issue_path(@site_visit.claim_issue_id, section: :site_visit)}'; </script>"
    else
      render :edit, layout: false
    end
  end

  def destroy
  end

  private
    def set_site_visit
     @site_visit ||= Teknion::SiteVisit.find(params[:id])
    end

    def site_visit_params
      params.require(:teknion_site_visit).permit(:claim_issue_id, :appointment_date, :appointment_time, :author, :confirmed_by, :site_visit_name)
    end
end
