Rails.application.routes.draw do
  devise_for :users
  root to: 'facilities#index'
  resources :facilities, only: [:index, :new, :create]
  post '/facilities/prefecture', to: 'facilities#post_json_city'
  post '/facilities/city', to: 'facilities#post_json_name'
  post '/facilities/name', to: 'facilities#post_json_area'
end
