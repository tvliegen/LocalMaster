class Portalmanager::AppdefsController < ApplicationController
  before_action :set_portalmanager_appdef, only: [:show, :edit, :update, :destroy]

  # GET /portalmanager/appdefs
  # GET /portalmanager/appdefs.json
  def index
    @portalmanager_appdefs = Portalmanager::Appdef.all
    
  
    
  end

  # GET /portalmanager/appdefs/1
  # GET /portalmanager/appdefs/1.json
  def show

  end

  # GET /portalmanager/appdefs/new
  def new
    @portalmanager_appdef = Portalmanager::Appdef.new
  end

  # GET /portalmanager/appdefs/1/edit
  def edit
 
  end

  # POST /portalmanager/appdefs
  # POST /portalmanager/appdefs.json
  def create

    @portalmanager_appdef = Portalmanager::Appdef.new(portalmanager_appdef_params)

    respond_to do |format|
      if @portalmanager_appdef.save
       format.html { redirect_to portalmanager_appdefs_url }
 #   format.html {"<script>alert "created.";</script>"}
      format.json { head :no_content }
      	      
      #	      format.html { redirect_to @portalmanager_appdef, notice: 'Appdef was successfully createdxxx.' }
   #     format.json { render action: 'show', status: :created, location: @portalmanager_appdef }
      else
        format.html { render action: 'new' }
        format.json { render json: @portalmanager_appdef.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /portalmanager/appdefs/1
  # PATCH/PUT /portalmanager/appdefs/1.json
  def update
    respond_to do |format|
      if @portalmanager_appdef.update(portalmanager_appdef_params)
      	      
      	        format.html { redirect_to portalmanager_appdefs_url }
      format.json { head :no_content }
    #    format.html { redirect_to @portalmanager_appdef, notice: 'Appdef was successfully updated.' }
   #     format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @portalmanager_appdef.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /portalmanager/appdefs/1
  # DELETE /portalmanager/appdefs/1.json
  def destroy
    @portalmanager_appdef.destroy
    respond_to do |format|
      format.html { redirect_to portalmanager_appdefs_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_portalmanager_appdef
      @portalmanager_appdef = Portalmanager::Appdef.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def portalmanager_appdef_params
    	    
    	      params.require(:portalmanager_appdef).permit(:application_title, :application_description, :application_url, :application_groups, :application_parent_menu)

    end
    
        def create_menu
    	 
    	    @portal_menu=Portalmanager::Appdef.all
    	   
    	 
    	    @portal_menu.where("parent_menu_item = application_title");
    	     @portal_menu.each do |menu_item|
    	     	 
    	     	     if menu_item.parent_menu_item.eql?(menu_item.application_title) 
    	     	     	@temp_menu_item=Array.new  
    	     	     	     @temp_menu_item.push(menu_item.application_title)
    	     	     #	 @sub_menu=Portalmanager::Appdef.all
    	     	     	#    @sub_menu.where("parent_menu_item = application_title")
    	     	     	    
    	     	     	 #   @sub_menu.where.not(application_title: menu_item.application_title)
    	     	     	 submenu="Select * from portalmanager_appdefs where application_title != parent_menu_item and parent_menu_item= '" << menu_item.application_title << "'"
    	     	     	    @sub_menu=Portalmanager::Appdef.find_by_sql(submenu)
    	     	     	    @sub_menu.each do |sub_menu_item|
    	     	     	   	    @temp_menu_item.push(sub_menu_item.application_title)
    	     	   end
    	     	   @main_menu.push(@temp_menu_item)
    	end
end
    	 
    	
    	     		 
    	     	    
 end
end
