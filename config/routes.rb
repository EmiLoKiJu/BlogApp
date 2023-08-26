Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create], controller: 'user_posts' do
      resources :comments, only: [:new, :create], controller: 'user_post_comments'
      resources :likes, only: [:create], controller: 'user_post_likes'
    end
  end
end
