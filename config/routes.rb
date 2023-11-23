Rails.application.routes.draw do
  devise_for :users
  root "home#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")


  namespace :admin do 
    resources :users
    get '/dashboard', to: "dashboard#index"
  end
  
  get "/customer", to: "customers#index"
  resources :shipments
end
