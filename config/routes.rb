# frozen_string_literal: true

Rails.application.routes.draw do
  resources :fund_transactions, %i[index new create]
  resources :friendships, %i[index create update destroy]
  resources :wallets, %i[new create update]
  devise_for :users
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root to: 'home#index'
end
