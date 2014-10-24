Teknion::Application.routes.draw do


  namespace :usermanagement do
    resources :users
  
  end

  namespace :teknionline do
 
    post  '/profiles/update', to: 'profiles#update'
    get  '/profiles/edit', to:  'profiles#edit', as: 'edit_teknionline_profile'
    get '/profiles/switch/:id', to: 'profiles#switch'
                   
  end

  namespace :login do
    get 'authenticates/login', to: 'authenticates#login'
    get 'authenticates/logout', to: 'authenticates#logout'
    post 'authenticates/idpLogin', to: 'authenticates#idpLogin'
    get 'authenticates/setsession', to: 'authenticates#set_session'
    get 'authenticates/validatesession', to: 'authenticates#validate_session'
  end



  namespace :portalmanager do
    resources :appdefs
  end


 

  namespace :teknionline do
    get '/mains', to: 'mains#index', as: 'teknionline_mains'
  end
  root 'teknionline/mains#index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
