Rails.application.routes.draw do
  constraints Clearance::Constraints::SignedIn.new do
    root "dashboards#show", as: :signed_in_root
  end

  root "homes#show"

  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, only: [:create]

  resources :users, only: [:create, :show] do
    resource :password,
      controller: "clearance/passwords",
      only: [:edit, :update]
  end

  resources :shouts, only: [:create, :show]
  
  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
