Rails.application.routes.draw do
  resources :listings do
    resources :bookings, only: [:new, :create, :edit, :update, :show, :destroy]
  end
  resources :bookings do
    resources :braintree, only: [:new, :create]
  end
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]
  resources :users, only: [:index, :edit, :show, :destroy, :update]
  resources :users, controller: "clearance/users", only: [:create] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
  end

  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "sessions#destroy", as: "sign_out"
  get "/sign_up" => "users#new", as: "sign_up"
  root "welcome#home"
  get "/auth/:provider/callback" => "sessions#create_from_omniauth"
  get "/listings" => "listings#index"
  get "/bookings" => "bookings#index"

  get '/search', to: 'listings#search', as: 'search'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
