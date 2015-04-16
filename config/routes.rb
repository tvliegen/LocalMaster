Teknion::Application.routes.draw do

  mount Bootsy::Engine => '/bootsy', as: 'bootsy'
  namespace :internal do
    resources :massmails
  end

  namespace :internal do
    resources :installer_certfication_certs
  end

  namespace :internal do
    resources :installer_certifications_installers
  end

  namespace :internal do
    resources :installer_certifications
  end


  namespace :dealermanager do
    resources :managers
  end


  namespace :usermanagement do
    resources :users
    get '/searchusers', to: 'users#search'
    get '/addotheruser', to: 'users#addotheruser'
    post '/users/step2', to: 'users#addstep2', as: 'add_user_step_2'
    post '/users/checkuser', to: 'users#checkuser', as: 'checkuser'
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
  # scope module: 'teknion', as: 'tekcare' do
   namespace :tekcare do
    resources :claims, only: [:index, :show] do
      get :close
      resources :claim_issues, only: :index
    end
    
    get 'claim/search', to: 'claims#search'
    get 'admin', to: 'user_admin#index'
    get 'claimsrequests', to: 'claim_requests#index'
    get 'rga/bol', to: 'rga#bol'
    get 'rga/comminvoice', to: 'rga#comminvoice'
    get 'rga/rgadoc', to: 'rga#rgadoc'
    get 'rga/rgapack', to: 'rga#rgapack'
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
    resources :back_charges, only: [:show, :update, :destroy]
    
  end

 

  match '/oe', :to => redirect('/public/os/index.html'), via: [:get, :post]
  match '/tekcarehelp', :to =>redirect('/public/tekcare_help'), via: [:get, :post]
 
end
