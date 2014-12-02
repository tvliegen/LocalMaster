class Api::SiteVisitsController < Api::ApiController
  before_action :set_site_visit, only: [:show, :edit, :update, :destroy]

  def index
    @site_visits = ClaimIssue.find(params[:claim_issue_id]).site_visits.order(updated_at: :desc)
    render json: @site_visits
  end

  def show
    render json: @site_visit
  end

  def new
    @site_visit = SiteVisit.new
  end

  def edit
  end

  def update
    if @site_visit.update(site_visit_params)
      render nothing: true, status: :created
    else
      render json: @site_visit.errors, status: :unprocessable_entity
    end
  end

  def create
    @site_visit = SiteVisit.new(site_visit_params)

    if @site_visit.save
      render nothing: true, status: :created
    else
      render json: @site_visit.errors, status: :unprocessable_entity
    end
  end

  private
    def set_site_visit
      @site_visit = SiteVisit.find(params[:id])
    end

    def site_visit_params
      params.permit(:claim_issue_id, :appointment_date, :appointment_time, :author, :confirmed_by, :site_visit_name)
    end
end
