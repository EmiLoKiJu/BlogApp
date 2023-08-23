# Remplazed frozen_string_literal true for something else

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show], controller: 'user_posts'
  end
end
