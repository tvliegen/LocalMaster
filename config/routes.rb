Teknion::Application.routes.draw do

  namespace :dealermanager do
    resources :managers
  end

  namespace :teknion do
    resources :backcharges
  end

  namespace :usermanagement do
    resources :users
    post '/users/search', to: 'users#search'
    post '/users/addotheruser', to: 'users#addotheruser'
    post '/users/step2', to: 'users#addstep2', as: 'add_user_step_2'
  end

  namespace :teknionline do
    post  '/profiles/update', to: 'profiles#update'
    get  '/profiles/edit', to:  'profiles#edit', as: 'edit_teknionline_profile'
    get '/profiles/switch/:id', to: 'profiles#switch'
  end

  namespace :utilities do
    get '/getfoldercontents', to: 'attachments#get_folder_contents'
    get '/new', to: 'attachments#new'
    post '/upload', to: 'attachments#upload'
    post '/create', to: 'attachments#foreign_upload'
    post '/createfromfn', to: 'attachments#get_from_fn'
    get '/pullfn', to: 'util#pullfn'
  end
  namespace :login do
    get 'authenticates/login', to: 'authenticates#login'
    get 'authenticates/logout', to: 'authenticates#logout'
    post 'authenticates/idpLogin', to: 'authenticates#idpLogin'
    get 'authenticates/setsession', to: 'authenticates#set_session'
    get 'authenticates/validatesession', to: 'authenticates#validate_session'
    get 'authenticates/loginfn', to: 'authenticates#login_fotonotes'
  end

  namespace :portalmanager do
    resources :appdefs
  end

  namespace :teknionline do
    get '/mains', to: 'mains#index', as: 'teknionline_mains'
  end
  root 'teknionline/mains#index'

  # Tekcare routes
   scope module: 'teknion', as: 'teknion' do
   
     resources :claims, only: [:index, :show] do
      get :close
      resources :claim_issues, only: :index
    end
    get 'claim/search', to: 'claims#search'
    resources :claim_issues, only: :show do
      resources :clarifications, shallow: true
      resources :journals, only: [:index, :new, :create, :edit, :show]
      resources :back_charges, only: [:index, :new, :create, :edit]
      resources :site_visits, shallow: true, only: [:show, :edit, :update]
      resources :attachments, only: [:new, :create,:index]
      post 'closereq', to: 'claim_issues#close_request_create'
      get 'closereq/new', to: 'claim_issues#close_request_new'
      post 'back_charges/closereq', to: 'back_charges#close_request_create'
      get 'back_charges/closereq/new', to: 'back_charges#close_request_new'
    end
    resources :journals, only: [:show, :update, :destroy]
    resources :back_charges, only: [:show, :update, :destroy]
    
  end

  scope module: 'teknion', as: 'teknion' do
    get 'claimsrequests', to: 'claim_requests#index'
    get 'rga/bol', to: 'rga#bol'
    get 'rga/comminvoice', to: 'rga#comminvoice'
    get 'rga/rgadoc', to: 'rga#rgadoc'
    get 'rga/rgapack', to: 'rga#rgapack'
   
 end

  match '/oe', :to => redirect('/public/os/index.html'), via: [:get, :post]
  match '/tekcarehelp', :to =>redirect('/public/tekcare_help'), via: [:get, :post]
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
