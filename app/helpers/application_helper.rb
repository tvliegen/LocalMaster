module ApplicationHelper
	
	def create_menu()
		@main_menu=Array.new
		@userAccounts=Array.new
		@groups=Array.new
		@groups=session[:Groups].grep(/#{session[:DealerCode]}/)
		@portal_menu=Portalmanager::Appdef.all
		
		
		@portal_menu.where("application_parent_menu = application_title");
		@portal_menu.each do |menu_item|
			
			if menu_item.application_parent_menu.eql?(menu_item.application_title) 
				@temp_menu_item=Array.new  
				@temp_menu_item.push(menu_item.application_title)
				
				submenu="Select * from portalmanager_appdefs where application_title != application_parent_menu and application_parent_menu= '" << menu_item.application_title << "'"
				@sub_menu=Portalmanager::Appdef.find_by_sql(submenu)
				@sub_menu.each do |sub_menu_item|
					
					if !(@groups.grep(/#{sub_menu_item.application_groups}/).empty?)   
						
						@temp_menu_item.push(sub_menu_item.application_title)
					end
				end
				@main_menu.push(@temp_menu_item)
				
			end
		end
	end
	
	def getAccounts(userGroups)
		
		@groups=Array.new
		@dealerAccounts=Array.new
		@groups=userGroups
		@dealerGroups=@groups.grep(/all/)
		@dealerGroups.each do |group_Name|
			@tempGroup=group_Name.split('|')
			@temp_dealer_group=@tempGroup[0].split('.')
			dealer_account="#{@tempGroup[1]}|#{@temp_dealer_group[1]}"
			@dealerAccounts.push(dealer_account)
		end
		
		return @dealerAccounts
	end
	
end




