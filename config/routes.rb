Rails.application.routes.draw do

  root to: 'pages#home'

  get '/info', to: 'pages#info', as: 'info'

  resources :cities
  resources :restaurants
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
