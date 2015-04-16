class Tekcare::ClarificationsController < ApplicationController
  before_action :set_clarification, only: [:show, :edit]

  def show
  end

  def edit
    render :edit, layout: false
  end

  def new
    @claim_id = params[:claim_id]
    @clarification = Tekcare::Clarification.new(issue_id: params[:claim_issue_id])
    @clarification.type = 'question'
  end

  def create
     if params['tekcare_clarification'].key?('file_uploaded')
   
    if !params['tekcare_clarification']['file_uploaded'].nil?
       attach=Attachments.new
      results=attach.process_file(params['tekcare_clarification']['file_uploaded'],['Tekcare',params[:claim_issue_id]],'None')
       logger.info results
    end
     end
    clarification_data = clarification_params.merge!({issue_id: params[:claim_issue_id]})

    @clarification = Tekcare::Clarification.new(clarification_data)

    if @clarification.valid?
      
      @new_clarification = { :issue_id => @clarification.issue_id, :type => 'QUESTION', :subject => @clarification.subject, :content => @clarification.content,:sent_by => session[:FirstName] + ' ' + session[:LastName], :sent_to => "ANYONE"  }
      

      clarification_response = tekcare_connection.post do |req|
        req.url "tekcare/clarifications?dealer_code=#{session[:DealerCode]}"
        req.headers['Content-Type'] = 'application/json'
        req.body = @new_clarification.to_json
      end
      logger.info "Clarification Response: #{clarification_response.status}"
      logger.info "Clarification Body: #{@new_clarification.to_json}"
     
      if clarification_response.status == 201
        flash[:notice] = 'Clarification was successfully created.'
	
      else
        flash[:notice] = 'There was a problem creating your Clarification.'
      end
      
      render inline: "<script> window.location.href = '#{tekcare_claim_issue_path(@clarification.issue_id, claim_id: params[:claim_id])}'; </script>"
    else
     
      render :new, layout: false
    end
    
  end

  def update

     if params.key?('tekcare_clarification')
    if !params['tekcare_clarification']['file_uploaded'].nil?
   attach=Attachments.new
      results=attach.process_file(params['tekcare_clarification']['file_uploaded'],['Tekcare',params[:answer_issue_id]],'None')
       logger.info results
    
    end
     end
    @answer = Tekcare::Clarification.new({
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
        req.url "tekcare/clarifications?dealer_code=#{session[:DealerCode]}"
        req.headers['Content-Type'] = 'application/json'
        req.body = @answer.to_json
      end
 
      if clarification_response.status == 201
        flash[:notice] = 'Clarification was successfully updated.'
      else
        flash[:notice] = 'There was a problem updating your Clarification.'
      end
      render inline: "<script> window.location.href = '#{tekcare_claim_issue_path(@answer.issue_id, claim_id: params[:claim_id])}'; </script>"
    else
      render :edit, layout: false
    end

  end

  private
    def set_clarification
      @claim_id = params[:claim_id]
      dealer_code=session[:DealerCode]
      clarifications_response = tekcare_connection.get "tekcare/issues/#{params[:claim_issue_id]}/clarificationlist", {dealer_code: dealer_code}
      clarifications = clarifications_response.body['clarifications']
      clarification_data = clarifications.find {|cl| cl['clarification_id'] == params[:id] }
      @clarification = Tekcare::Clarification.new(clarification_data)
      answer_data = clarifications.find {|cl| cl['response_to_id'] == @clarification.clarification_id }
      logger.info "Answer Found: #{answer_data.present?}"
        if answer_data.present?
          @answer = Tekcare::Clarification.new(answer_data)
	else
	  @answer = Tekcare::Clarification.new({
            issue_id: params[:claim_issue_id],
            subject: "RE: #{@clarification.subject}",
            response_to_id: @clarification.clarification_id,
            type: 'answer',
            clarification_type: 'answer',
            content: '',
            sent_to: @clarification.sent_by,
            sent_by: @clarification.sent_by
          })
	end
	
	
     # if @clarification.clarification_type == 'answer'
     #   question = clarifications.find {|cl| cl['clarification_id'] == @clarification.response_to_id }
     #   @question = Tekcare::Clarification.new(question)
     #   @clarification.type = 'answer'
     # else
     #   @clarification.type = 'question'

        # when the question already has an answer, we'll need to find it for display.
        # otherwise, we'll just create a new answer for the view.
     #   answer_data = clarifications.find {|cl| cl['response_to_id'] == @clarification.clarification_id }
     #   if answer_data.present?
     #     @answer = Tekcare::Clarification.new(answer_data)
     #   else
      #    @answer = Tekcare::Clarification.new({
      #      issue_id: params[:claim_issue_id],
      #      subject: "RE: #{@clarification.subject}",
      #      response_to_id: @clarification.clarification_id,
      #      type: 'answer',
      #      clarification_type: 'answer',
      #      content: '',
      #      sent_to: @clarification.sent_by,
      #      sent_by: @clarification.sent_by
      #   })
      #  end
     # end
    end

    def clarification_params
      params.require(:tekcare_clarification)
    end

    def answer_params
      params.permit(:answer_content, :answer_issue_id, :answer_subject, :answer_response_to_id, :answer_type, :answer_sent_by, :answer_sent_to)
    end
end
