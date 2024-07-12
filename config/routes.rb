Rails.application.routes.draw do
  root 'posts#index'
  devise_for :users
  scope module: :users do
    resources :posts, only: %i[new create edit update destroy]
    resource :relationships, only: %i[create destroy]
  end
  resources :posts, only: %i[index show] do
    resource :likes, only: %i[create destroy], module: :posts
    resources :like_users, only: %i[index], module: :posts
  end
end
