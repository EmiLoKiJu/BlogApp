Rails.application.routes.draw do
  root to: 'users#index'

  devise_for :users, controllers: { registrations: 'users/registrations' }, skip: [:sessions]
  devise_scope :user do
    get 'log_in', to: 'devise/sessions#new', as: :new_user_session
    post 'log_in', to: 'devise/sessions#create', as: :user_session
    delete 'log_out', to: 'devise/sessions#destroy', as: :destroy_user_session
    get "/custom_sign_out" => "devise/sessions#destroy", as: :custom_destroy_user_session
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create], controller: 'user_posts' do
      resources :comments, only: [:new, :create], controller: 'user_post_comments'
      resources :likes, only: [:create], controller: 'user_post_likes'
    end
  end
end
