class Teknion::AttachmentsController < ApplicationController
  
    def show
    end
    def index
    
       issue_attachments=Attachments.new
       @attachments=Array.new
       @attachments = issue_attachments.search_app_files(params[:claim_issue_id])
       @issue_id=params[:claim_issue_id]
	 
    end
    def new
      @attachment=Teknion::Attachment.new
      @attachment.issue_id=params[:claim_issue_id]
      @attachment.claim_issue_id=params['claim_id']
      @claim_id = params[:claim_id]
    
    end

	def create
   
    attach=Attachments.new
    

    if !params['teknion_attachment']['description'].nil?
      description='None'
    else
      description=params['teknion_attachment']['description']
    end
    
    if !params['teknion_attachment']['file_uploaded'].nil?
       results=attach.process_file(params['teknion_attachment']['file_uploaded'],['Tekcare',params[:claim_issue_id]],description)
       logger.info results
    end
    if params.key?(:claim_id)
      complete_url="#{teknion_claim_issue_path(params[:claim_issue_id], claim_id: params[:claim_id],section: 'attachments')}"
    else
      complete_url="#{teknion_claim_issue_attachments_path(params[:claim_issue_id])}"
    end
    
    render inline: "<script> window.location.href = '#{complete_url}'; </script>" 

	end
end
