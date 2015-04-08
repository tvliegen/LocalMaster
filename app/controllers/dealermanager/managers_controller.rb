class Dealermanager::ManagersController < ApplicationController
  before_action :set_dealermanager_manager, only: [:show, :edit, :update, :destroy]

  # GET /dealermanager/managers
  def index
    @dealermanager_managers = Dealermanager::Manager.all
  end

  # GET /dealermanager/managers/1
  def show
  end

  # GET /dealermanager/managers/new
  def new
    @dealermanager_manager = Dealermanager::Manager.new
  end

  # GET /dealermanager/managers/1/edit
  def edit
  end

  # POST /dealermanager/managers
  def create
    @dealermanager_manager = Dealermanager::Manager.new(dealermanager_manager_params)

    if @dealermanager_manager.save
      redirect_to @dealermanager_manager, notice: 'Manager was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /dealermanager/managers/1
  def update
    if @dealermanager_manager.update(dealermanager_manager_params)
      redirect_to @dealermanager_manager, notice: 'Manager was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /dealermanager/managers/1
  def destroy
    @dealermanager_manager.destroy
    redirect_to dealermanager_managers_url, notice: 'Manager was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dealermanager_manager
      @dealermanager_manager = Dealermanager::Manager.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def dealermanager_manager_params
      params[:dealermanager_manager]
    end
end
