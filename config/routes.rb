Rails.application.routes.draw do
  resources :accounts, only: [:new, :create]
  resources :musics, only: [:index, :create, :show, :destroy, :update]

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  root 'musics#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
