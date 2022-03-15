Rails.application.routes.draw do
  constraints Clearance::Constraints::SignedIn.new do
    root "dashboards#show", as: :signed_in_root
  end

  root "homes#show"
  post :text_shouts, to: "shouts#create", defaults: { content_type: TextShout }
  post :photo_shouts, to: "shouts#create", defaults: { content_type: PhotoShout }

  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, only: [:create]

  resources :hashtags, only: [:show]

  resources :users, only: [:create, :show] do
    resources :followers, only: [:index]
    member do
      post :follow, to: "followed_users#create"
      delete :unfollow, to: "followed_users#destroy"
    end
    resource :password,
      controller: "clearance/passwords",
      only: [:edit, :update]
  end

  resources :shouts, only: [:show] do
    member do 
      post :like, to: "likes#create"
      delete :unlike, to: "likes#destroy"
    end
  end
  
  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
