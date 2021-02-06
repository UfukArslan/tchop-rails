Rails.application.routes.draw do

  get '/info', to: 'pages#info'

  resources :cities
  resources :restaurants
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
