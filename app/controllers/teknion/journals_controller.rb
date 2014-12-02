class Teknion::JournalsController < ApplicationController
  before_action :set_journal, only: [:show, :edit, :update, :destroy]

  def index
    @journals = Teknion::ClaimIssue.find(params[:claim_issue_id]).journals
  end

  def show
  end

  def edit
    render :edit, layout: false
  end

  def new
    @journal = Teknion::ClaimIssue.find(params[:claim_issue_id]).journals.build
    @journal.journal_attachments = 2.times.map { @journal.journal_attachments.build }
  end

  def create
    @journal = Teknion::ClaimIssue.find(params[:claim_issue_id]).journals.build(journal_params)

    if @journal.valid?
      params[:teknion_journal].merge!({claim_issue_id: params[:claim_issue_id]})
      HTTMultiParty.post("http://localhost:3001/api/claim_issues/#{params[:claim_issue_id]}/journals", {body: params})
      flash[:notice] = 'Journal was successfully updated.'
      render inline: "<script> window.location.href = '#{teknion_claim_issue_path(@journal.claim_issue_id, section: :other_information)}'; </script>"
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
      render inline: "<script> window.location.href = '#{teknion_claim_issue_path(@journal.claim_issue_id, section: :other_information)}'; </script>"
    else
      render :edit, layout: false
    end
  end

  def destroy
  end

  private
    def set_journal
      @journal ||= Teknion::Journal.find(params[:id])
    end

    def journal_params
      params.require(:teknion_journal)
        .permit(:author, :title, :information,
          journal_attachments_attributes: [:attachment, :id])
    end
end

