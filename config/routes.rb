# frozen_string_literal: true

Rails.application.routes.draw do
  resources :user, only: %i[show]
  resources :dashboard, only: %i[index]
  resources :fund_transactions, only: %i[index new create]
  resources :friendships, except: %i[:show]
  resources :wallets, only: %i[new create update]
  resources :home, only: %i[index]
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root to: 'home#index'
end
