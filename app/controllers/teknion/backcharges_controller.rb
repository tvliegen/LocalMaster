class Teknion::BackchargesController < ApplicationController
  before_action :set_teknion_backcharge, only: [:show, :edit, :update, :destroy]

  # GET /teknion/backcharges
  def index
    @teknion_backcharges = Teknion::Backcharge.all
  end

  # GET /teknion/backcharges/1
  def show
  end

  # GET /teknion/backcharges/new
  def new
    @teknion_backcharge = Teknion::Backcharge.new
  end

  # GET /teknion/backcharges/1/edit
  def edit
  end

  # POST /teknion/backcharges
  def create
    @teknion_backcharge = Teknion::Backcharge.new(teknion_backcharge_params)

    if @teknion_backcharge.save
      redirect_to @teknion_backcharge, notice: 'Backcharge was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /teknion/backcharges/1
  def update
    if @teknion_backcharge.update(teknion_backcharge_params)
      redirect_to @teknion_backcharge, notice: 'Backcharge was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /teknion/backcharges/1
  def destroy
    @teknion_backcharge.destroy
    redirect_to teknion_backcharges_url, notice: 'Backcharge was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_teknion_backcharge
      @teknion_backcharge = Teknion::Backcharge.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def teknion_backcharge_params
      params[:teknion_backcharge]
    end
end
