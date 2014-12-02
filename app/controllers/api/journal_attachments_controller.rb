class Api::JournalAttachmentsController < Api::ApiController
  before_action :set_journal_attachment, only: [:show, :edit, :update, :destroy]

  respond_to :json

  def index
    @journal_attachments = Journal.find(params[:journal_id]).journal_attachments.order(updated_at: :desc)
    render json: @journal_attachments
  end

  def show
    render json: @journal_attachment
  end

  def new
    @journal_attachment = JournalAttachment.new
  end

  def update
    if @journal_attachment.update(journal_attachment_params)
      render nothing: true, status: :created
    else
      render json: @journal_attachment.errors, status: :unprocessable_entity
    end
  end

  def create
    @journal_attachment = JournalAttachment.new(journal_attachment_params)

    if @journal_attachment.save
      render nothing: true, status: :created
    else
      render json: @journal_attachment.errors, status: :unprocessable_entity
    end
  end

  private
    def set_journal_attachment
      @journal_attachment ||= JournalAttachment.find(params[:id])
    end

    def journal_attachment_params
      #params.permit(:claim_issue_id, :subject, :question, :answer, :author)
    end
end
