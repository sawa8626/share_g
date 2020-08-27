Rails.application.routes.draw do
  devise_for :users
  root to: 'facilities#index'
  resources :facilities, only: [:index, :new, :create]
  get '/facilities/:id', to: 'facilities#post_json'
end
