Rynda::Application.routes.draw do

  resources :sessions, :only => [:new, :create, :destroy]

  resources :users do
    member do
      get :manage_roles
      put :process_roles
    end
  end
  
  resources :roles do
    member do
      get :manage_privileges
      put :process_privileges
    end
  end

  resources :communities do
    member do
      get :manage_members
      put :process_members
    end
  end

  resources :companies do
    member do
      get :switch_current
      put :make_current
    end
  end

  resources :business_units
  resources :departments

  resources :service_requests do
    member do
      put :make_sent
      get :select_prfm_community
      put :make_received
      get :approving
      put :make_approved
      get :returning
      put :make_returned
      get :show_status_track
    end
    collection do
      post :show_list
    end
  end

  resources :service_operations do
    member do
      put :make_planned
      get :select_performer
      put :make_assigned
      get :activation
      put :make_activated
      get :committing
      put :make_committed
      get :cancellation
      put :make_canceled
      get :show_status_track
    end
    collection do
      post :show_list
    end
  end

  match '/signup' , :to => 'users#new'
  match '/signin' , :to => 'sessions#new'
  match '/signout', :to => 'sessions#destroy'

  match '/contact_info', :to => 'pages#contact_info'
  match '/about'       , :to => 'pages#about'
  match '/help'        , :to => 'pages#help'

  root :to => 'pages#home'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'

end
