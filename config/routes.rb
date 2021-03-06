Myapp::Application.routes.draw do
  get '/', to: 'home#index'
  get '/home', to: 'home#index'
  get '/contests', to: 'contests#index'
  get '/contests/all', to: 'contests#all'
  get '/contests/new', to: 'contests#new'
  get '/contests/me', to: 'contests#me'
  get '/submissions', to: 'submissions#index'

  get '/users/:id', to: 'users#show'
  get '/submissions/me', to: 'submissions#me'
  get '/submissions/:id', to: 'submissions#show'
  get '/contests/:id', to: 'contests#show'
  get '/contests/update/:id', to: 'contests#update'
  get '/contests/view/:id', to: 'contests#view'

  post '/users', to: 'users#create'
  post '/submissions', to: 'submissions#create'
  post '/contests', to: 'contests#create'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
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
