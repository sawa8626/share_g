Rails.application.routes.draw do
  devise_for :users
  root to: 'facilities#index'
  resources :facilities, only: [:index, :new, :create] do
    resources :reservations, only: [:index, :new, :create]
    get '/reservations/get', to: 'jsons#get_reservations'
  end
  resources :teams, only: [:new, :create, :show, :edit, :update, :destroy]
  resources :team_users, only: [:update, :destroy]

  # Root for JSON
  post '/facilities/prefecture', to: 'jsons#post_city'
  post '/facilities/city', to: 'jsons#post_name'
  post '/facilities/name', to: 'jsons#post_area'
  post '/facilities/area', to: 'jsons#post_facility_id'
end
