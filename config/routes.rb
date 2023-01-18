# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  resources :dashboard, only: %i[index]
  resources :fund_transactions, only: %i[index new create]
  resources :friendships, except: %i[:show]
  resources :wallets, only: %i[new create update]
  resources :home, only: %i[index]
  resources :users, only: %i[show]
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root to: 'home#index'

  match "/404", to: "errors#not_found", via: :all
  match "/500", to: "errors#internal_server_error", via: :all
  match '*unmatched', to: "errors#not_found", via: :all
end
