class Teknion::ClarificationsController < ApplicationController
  before_action :set_clarification, only: [:show, :edit]

  def show
  end

  def edit
    render :edit, layout: false
  end

  def new
    @claim_id = params[:claim_id]
    @clarification = Teknion::Clarification.new(issue_id: params[:claim_issue_id])
    @clarification.type = 'question'
  end

  def create
    clarification_data = clarification_params.merge!({issue_id: params[:claim_issue_id]})
    @clarification = Teknion::Clarification.new(clarification_data)

    if @clarification.valid?
      clarification_response = tekcare_connection.post do |req|
        req.url 'tekcare/clarifications?dealer_code=200188'
        req.headers['Content-Type'] = 'application/json'
        req.body = @clarification.to_json
      end

      if clarification_response.status == 201
        flash[:notice] = 'Clarification was successfully created.'
      else
        flash[:notice] = 'There was a problem creating your Clarification.'
      end
      render inline: "<script> window.location.href = '#{teknion_claim_issue_path(@clarification.issue_id, claim_id: params[:claim_id])}'; </script>"
    else
      render :new, layout: false
    end
  end

  def update
    @answer = Teknion::Clarification.new({
      issue_id:       answer_params[:answer_issue_id],
      subject:        answer_params[:answer_subject],
      content:        answer_params[:answer_content],
      response_to_id: answer_params[:answer_response_to_id],
      type:           answer_params[:answer_type],
      sent_to:        answer_params[:answer_sent_to],
      sent_by:        answer_params[:answer_sent_by]
    })

    if @answer.valid?
      clarification_response = tekcare_connection.post do |req|
        req.url 'tekcare/clarifications?dealer_code=200188'
        req.headers['Content-Type'] = 'application/json'
        req.body = @answer.to_json
      end

      if clarification_response.status == 201
        flash[:notice] = 'Clarification was successfully updated.'
      else
        flash[:notice] = 'There was a problem updating your Clarification.'
      end
      render inline: "<script> window.location.href = '#{teknion_claim_issue_path(@answer.issue_id, claim_id: params[:claim_id])}'; </script>"
    else
      render :edit, layout: false
    end
  end

  private
    def set_clarification
      @claim_id = params[:claim_id]

      clarifications_response = tekcare_connection.get "tekcare/issues/#{params[:claim_issue_id]}/clarificationlist", {dealer_code: "200188"}
      clarifications = clarifications_response.body['clarifications']
      clarification_data = clarifications.find {|cl| cl['clarification_id'] == params[:id] }
      @clarification = Teknion::Clarification.new(clarification_data)

      if @clarification.clarification_type == 'answer'
        question = clarifications.find {|cl| cl['clarification_id'] == @clarification.response_to_id }
        @question = Teknion::Clarification.new(question)
        @clarification.type = 'answer'
      else
        @clarification.type = 'question'

        # when the question already has an answer, we'll need to find it for display.
        # otherwise, we'll just create a new answer for the view.
        answer_data = clarifications.find {|cl| cl['response_to_id'] == @clarification.clarification_id }
        if answer_data.present?
          @answer = Teknion::Clarification.new(answer_data)
        else
          @answer = Teknion::Clarification.new({
            issue_id: params[:claim_issue_id],
            subject: "RE: #{@clarification.subject}",
            response_to_id: @clarification.clarification_id,
            type: 'answer',
            clarification_type: 'answer',
            content: '',
            sent_to: @clarification.sent_by,
            sent_by: 'MISSING_FROM_SESSION'
          })
        end
      end
    end

    def clarification_params
      params.require(:teknion_clarification)
    end

    def answer_params
      params.permit(:answer_content, :answer_issue_id, :answer_subject, :answer_response_to_id, :answer_type, :answer_sent_by, :answer_sent_to)
    end
end
