require 'sidekiq/web'

Rails.application.routes.draw do

  mount Sidekiq::Web => "/sidekiq"


  resources :reservations do

    member do 
      get 'accept'
      get 'reject'
    end
    
    get 'braintree/new'
    post 'braintree/checkout', as: "braintree_checkout"

  end

  resources :listings do
    resources :avatars, only: [:create, :destroy]
    resources :reservations, only: [:new, :create, :update]

    member do
      get 'verify'
    end

  end
  
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :sessions, controller: "sessions", only: [:create, :destroy] do
  end

  resources :users, controller: "users", only: [:show, :create, :edit, :update, :destroy] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
  end

  get "/sign_in" => "sessions#new", as: "sign_in"
  delete "/sign_out" => "sessions#destroy", as: "sign_out"
  get "/sign_up" => "users#new", as: "sign_up"
  # get "/user/:id/edit" => "users#edit", as: "edit_user"
  
  get :search, controller: :home
  get "search", to: "listings#index"

  root "home#home"
  get '/about' => "home#about", as: "about_us"

  get "/auth/:provider/callback" => "sessions#create_from_omniauth"

  # resources :search, only: [:edit]

  # get "/client_token" do
  #   gateway.client_token.generate
  # end

  # post "/checkout" do
  #   nonce_from_the_client = params[:payment_method_nonce]
  #   # Use payment method nonce here...
  # end

  # get "reservations/:id/new" => "reservations"


end

