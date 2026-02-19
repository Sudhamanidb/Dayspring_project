Rails.application.routes.draw do

  if Rails.env.development? #this is to visualize in web only
    mount LetterOpenerWeb::Engine, at: "/letter_opener" #LetterOpenerWeb::Engine-->this is engine
  end

  # create new folder inside config --> inside that create one new file name admin.rb
  draw :admin   # default drow will write route  ,,,, segregating / separating / devide the multiple file 

  get '/payment_details' ,to: 'payments#payment_modes'  #payments_details--> we can give anything
  root 'products#index'   #http://127.0.0.1:3000/--->this contains products index page not default home page
  get '/payment_details' ,to: 'payments#payment_modes',as:'payment_info'  # aliasing --> using this also we can access
  get '/products' , to: 'products#index',constraints:{format:"json"}   #--> product.json

  match '/login' ,to: 'products#index',via:[:get,:post] #It responds to both GET (loading the page) and POST (submitting data) requests.
  # When using match, Rails requires you to specify the HTTP methods using via:.
  # like constraints we can use regex 



  resources :orders   # when we use resources--> all 7 default routes will get generated
                       #  when we use resource --> 6 routes will generate ,index route will not generate                
  resources :products  do
    member do
      get 'analytics'
      get 'post'
    end
    collection do
      get 'out_of_stock'
    end
  end

  namespace :product do
     resources :categories do 
      collection do
        get 'review'
      end
     end
  end
  
  namespace :admin do
    resources :dashboard
    # resources :reports
  end

  scope module: :admin do
    resources :reports
  end
  
  # namespace :product do
  #   resources :categories
  # end
  
  # resources :products, only: [:new] do
  #   collection do 
  #     get 'out-of-stock'
  #   end
  # end

resources :customers do
   scope '/people' do
    resources :customers do 
      end
    collection do
      get 'blacklisted_customers'
    end
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

  # resources :products, only: [:show]
  #  resources :products, except: [:show]  ---> less than 8 except will not work so use skip
  # resources :products, expect: [:new,:delete,:show]  

  # Defines the root path route ("/")
  # root "posts#index"

  get '*path' , to:redirect("/")



end

