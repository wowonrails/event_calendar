Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations" }

  authenticated :user do
    root to: "pages#home"
  end

  root to: "pages#welcome"

  resources :events

  resources :users, only: :show do
    resources :followed_users, only: :index
    resources :followers,      only: :index
    resources :other_users,    only: :index
    resources :relationships,  only: %i[create destroy]
    resources :events,         only: %i[index show], controller: "users/events"
  end
end
