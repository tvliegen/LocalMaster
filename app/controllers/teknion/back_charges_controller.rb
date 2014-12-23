class Teknion::BackChargesController < ApplicationController
  before_action :set_back_charge, only: [:show, :edit, :update]

  def show
  end

  def edit
    @claim_issue_id = params[:claim_issue_id]
    @claim_id = params[:claim_id]
    render :edit, layout: false
  end

  def new
    @claim_id = params[:claim_id]
    @back_charge = Teknion::BackCharge.new(issue_id: params[:claim_issue_id])
  end

  def create
    back_charge_data = params[:teknion_back_charge].merge!({issue_id: params[:claim_issue_id]})
    @back_charge = Teknion::BackCharge.new(back_charge_data)

    if @back_charge.valid?
      #TODO: Back charge save
      if back_charge_response.status == 201
        flash[:notice] = 'Back Charge was successfully updated.'
      else
        flash[:notice] = 'There was a problem creating your Back Charge.'
      end

      render inline: "<script> window.location.href = '#{teknion_claim_issue_path(@back_charge.issue_id, section: :other_information, claim_id: params[:claim_id])}'; </script>"
    else
      render :new, layout: false
    end
  end

  def update
    @back_charge.assign_attributes(back_charge_params)

    if @back_charge.valid?
      #TODO: Back charge save
      render inline: "<script> window.location.href = '#{teknion_claim_issue_path(@back_charge.claim_issue_id, section: :other_information, claim_id: params[:claim_id])}'; </script>"
    else
      render :edit, layout: false
    end
  end

  private
    def set_back_charge
      dealer_code=session[:DealerCode]
      @claim_id = params[:claim_id]
      @back_charge ||= Teknion::BackCharge.find(params[:id], params[:claim_issue_id], dealer_code)
    end

    def back_charge_params
      params.require(:teknion_back_charge)
    end
end
