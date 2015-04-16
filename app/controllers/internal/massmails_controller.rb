class Internal::MassmailsController < ApplicationController
  before_action :set_internal_massmail, only: [:show, :edit, :update, :destroy]

  # GET /internal/massmails
  def index
    @internal_massmails = Internal::Massmail.all
  end

  # GET /internal/massmails/1
  def show
  end

  # GET /internal/massmails/new
  def new
    @internal_massmail = Internal::Massmail.new
  end

  # GET /internal/massmails/1/edit
  def edit
  end

  # POST /internal/massmails
  def create
    @internal_massmail = Internal::Massmail.new(internal_massmail_params)

    if @internal_massmail.save
      redirect_to @internal_massmail, notice: 'Massmail was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /internal/massmails/1
  def update
    if @internal_massmail.update(internal_massmail_params)
      redirect_to @internal_massmail, notice: 'Massmail was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /internal/massmails/1
  def destroy
    @internal_massmail.destroy
    redirect_to internal_massmails_url, notice: 'Massmail was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_internal_massmail
      @internal_massmail = Internal::Massmail.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def internal_massmail_params
      params[:internal_massmail]
    end
end
