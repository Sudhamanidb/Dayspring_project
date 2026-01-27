Rails.application.routes.draw do
 resources :products, except: [:show]  do
    collection do
      get 'out_of_stock'
    end
  end

# resources :products, only: [:new] do
#   collection do 
#     get 'out-of-stock'
#   end
# end

resources :customers do
    collection do
      get 'blacklisted_customers'
    end
  end
  # resources :products
  get "home/index"
  resources :customers
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"

# resources :products, only: [:show]
#  resources :products, except: [:show]
# resources :products, expect: [:new,:delete,:show]

end

