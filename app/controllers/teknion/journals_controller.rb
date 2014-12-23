class Teknion::JournalsController < ApplicationController
  before_action :set_journal, only: [:show, :edit, :update, :destroy]

  def show
  end

  def edit
    render :edit, layout: false
  end

  def new
    @claim_id = params[:claim_id]
    @journal = Teknion::Journal.new(issue_id: params[:claim_issue_id])
  end

  def create
    journal_data = params[:teknion_journal].merge!({issue_id: params[:claim_issue_id]})
    @journal = Teknion::Journal.new(journal_data)
    dealer_code=session[:DealerCode]

    if @journal.valid?
      journal_response = tekcare_connection.post do |req|
        req.url 'tekcare/journals?dealer_code=#{dealer_code}'
        req.headers['Content-Type'] = 'application/json'
        req.body = @journal.to_json(only: [:issue_id, :subject, :content, :created_by])
      end

      if journal_response.status == 201
        flash[:notice] = 'Journal was successfully updated.'
      else
        flash[:notice] = 'There was a problem creating your Journal.'
      end

      render inline: "<script> window.location.href = '#{teknion_claim_issue_path(@journal.issue_id, section: :other_information, claim_id: params[:claim_id])}'; </script>"
    else
      render :new, layout: false
    end
  end

  def update
    @journal.assign_attributes(journal_params)

    if @journal.valid?
      # TODO: catch HTTMultiParty response code to determine success/failure -CS
      HTTMultiParty.put("http://localhost:3001/api/journals/#{params[:id]}", {body: params})
      flash[:notice] = 'Journal was successfully updated.'
      render inline: "<script> window.location.href = '#{teknion_claim_issue_path(@journal.claim_issue_id, section: :other_information, claim_id: params[:claim_id])}'; </script>"
    else
      render :edit, layout: false
    end
  end

  def destroy
  end

  private
    def set_journal
      dealer_code=session[:DealerCode]
      @claim_id = params[:claim_id]
      @journal ||= Teknion::Journal.find(params[:id], params[:claim_issue_id], dealer_code)
    end

    def journal_params
      params.require(:teknion_journal)
        .permit(:created_by, :subject, :content,
          journal_attachments_attributes: [:attachment, :id])
    end
end

