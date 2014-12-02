class Api::JournalsController < Api::ApiController
  before_action :set_journal, only: [:show, :edit, :update, :destroy]

  respond_to :json

  def index
    @journals = ClaimIssue.find(params[:claim_issue_id]).journals.order(updated_at: :desc)
    render json: @journals
  end

  def show
    render json: @journal
  end

  def new
    @journal = Journal.new
  end

  def update
    if @journal.update(journal_params)
      render nothing: true, status: :created
    else
      render json: @journal.errors, status: :unprocessable_entity
    end
  end

  def create
    @journal = Journal.new(journal_params)

    if @journal.save
      render nothing: true, status: :created
    else
      render json: @journal.errors, status: :unprocessable_entity
    end
  end

  private
    def set_journal
      @journal ||= Journal.find(params[:id])
    end

    def journal_params
      params.require(:teknion_journal)
        .permit(:author, :title, :information, :claim_issue_id,
          journal_attachments_attributes: [:attachment, :id])
    end
end


