Rails.application.routes.draw do
  resources :producers
  resources :companies
  resources :genres
  mount_devise_token_auth_for 'User', at: 'auth'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
