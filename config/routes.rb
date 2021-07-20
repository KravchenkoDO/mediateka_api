# frozen_string_literal: true
Rails.application.routes.draw do
  resources :producers
  resources :companies
  resources :posters
  resources :genres
  resources :actors
  resources :movies
  resources :user_movie_comments
  resources :users
  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
    sessions: 'users/sessions'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
