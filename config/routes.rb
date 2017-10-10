Rails.application.routes.draw do
  root to: "pages#home"
  devise_for :users, controllers: { registrations: "users/registrations" }
  resources :events

  resources :users, only: :show do
    resources :followed_users, only: :index
    resources :followers,      only: :index
    resources :other_users,    only: :index
    resources :relationships,  only: [:create, :destroy]
    resources :events,         only: [:index, :show], controller: 'users/events'
  end
end
