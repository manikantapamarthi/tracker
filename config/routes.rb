Rails.application.routes.draw do
  devise_for :users
  root "home#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")


  namespace :admin do 
    resources :users do
      patch 'activate_user', on: :member
      patch 'in_activate_user', on: :member 
    end
    get '/dashboard', to: "dashboard#index"
  end


  
  get "/customer", to: "customers#index"
  get "/delivery_partner", to: "delivery_partners#index"
  
  resources :shipments do
    get :get_status, on: :member
    get :track, on: :member
  end
end
