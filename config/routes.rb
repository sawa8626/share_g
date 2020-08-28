Rails.application.routes.draw do
  devise_for :users
  root to: 'facilities#index'
  resources :facilities, only: [:index, :new, :create]
  post '/facilities/prefecture', to: 'jsons#post_city'
  post '/facilities/city', to: 'jsons#post_name'
  post '/facilities/name', to: 'jsons#post_area'
  post '/facilities/area', to: 'jsons#post_facility_id'
end
