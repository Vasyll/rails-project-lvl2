# frozen_string_literal: true

Rails.application.routes.draw do
  root 'posts#index'

  resources :posts, only: %w[index new create show] do
    resources :comments, only: [:create], module: 'posts'
  end

  devise_for :users
end
