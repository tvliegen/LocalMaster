class ClaimsController < ApplicationController
  before_action :set_claim, only: [:show, :edit, :update, :destroy]

  def index
    if params[:status].present?
      @claims = Claim.where(status: params[:status])
    else
      @claims = Claim.all
    end
  end

  def show
  end

  def new
    @claim = Claim.new
  end

  def edit
  end

  def create
    @claim = Claim.new(claim_params)

    if @claim.save
      redirect_to @claim, notice: 'Claim was successfully created.'
    else
      render :new
    end
  end

  def update
    if @claim.update(claim_params)
      redirect_to @claim, notice: 'Claim was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @claim.destroy
    redirect_to claims_url, notice: 'Claim was successfully destroyed.'
  end

  private
    def set_claim
      @claim = Claim.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def claim_params
      params[:claim].permit(:tekcare_number, :title, :project, :created_by, :status)
    end
end
