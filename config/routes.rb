Rails.application.routes.draw do
  root to: "pages#home"

  get "/info", to: "pages#info", as: "info"
  get "/search" => "pages#search", :as => "search_page"
  get "/profil", to: "users#edit", as: "profil"
  patch "/profil", to: "users#update"

  resources :cities
  resources :restaurants
  resources :users, only: [:new, :create] do
    member do
      get "confirm"
    end
  end

  # Session
  get "/login", to: "sessions#new", as: :new_session
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy", as: :destroy_session

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
