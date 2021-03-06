require 'sidekiq/web'

Rails.application.routes.draw do

  resources :episodes
  resource :subscription
  resource :card
  
  get '/terms', to: 'home#terms'
  get '/privacy', to: 'home#privacy'

  namespace :admin do
    resources :users
    resources :announcements
    resources :services

    root to: "users#index"
  end

  resources :announcements, only: [:index]
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  root to: 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
