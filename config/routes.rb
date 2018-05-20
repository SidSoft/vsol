Vsol::Application.routes.draw do
  get "mails/list" => "smails#list"
  get '/login', to: "sessions#new"
  get "mails/send/:id" => "smails#delay_mail", as: 'mails/send'
  delete 'logout' => "sessions#destroy"
  post '/login', to: "sessions#create"
  get '/signup', to: "users#new"
  get '/sand', to: "sessions#sandbox"
  get '/auth/:provider/callback', to: 'sessions#create_social'
  get 'tsecret', to: "static_pages#top_secret"

  DelayedJobWeb.use Rack::Auth::Basic do |username, password|
    username == ENV['DJ_USER'] && password == ENV['DJ_PASS']
    end
  match "/delayed_job" => DelayedJobWeb, :anchor => false, :via => [:get, :post]

  resources :users
  resources :smails
  resources :account_activations, only: [:edit]
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root "static_pages#home"

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
