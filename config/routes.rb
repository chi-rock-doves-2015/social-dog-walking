Rails.application.routes.draw do

  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # backbone experimental routes: this doesn't work bc bb needs a #hash#
  # get '/backbone' => 'users#dashboard'

  # You can have the root of your site routed with "root"
  root 'welcome#index'


  resources :walks do
    resources :marks, only: [:create]
  end

  get '/users/territory' => 'users#territory'
  resources :users, except: [:index] do
    member do
      get 'welcome'
    end
    resources :dogs
    resources :walks, only: [:create, :index]
  end

  resource :local_areas, only: [:create, :index]

  # resource :dashboard, only: [:show]

  # get 'walks/in-progress' => 'walks#in_progress'

  # get '/dashboard' => 'users#dashboard', as: 'dashboard'

  get 'users/:user_id/neighbors' => 'users#neighbors'

  get '/dashboard' => 'users#dashboard'

  get '/login' => 'sessions#new'

  post '/login' => 'sessions#create'

  get '/logout' => 'sessions#destroy'

  get '/map-sandbox' => 'welcome#map_sandbox'

  get 'about' => 'welcome#about', as: :about

  post 'walks/:walk_id/end_walk' => 'walks#end_walk', as: :end_walk

  post '/users/:user_id/dogs/:id' => 'dogs#destroy', as: :destroy_dog


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
