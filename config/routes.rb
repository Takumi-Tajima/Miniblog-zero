Rails.application.routes.draw do
  root 'posts#index'
  devise_for :users
  scope module: :users do
    resources :posts, only: %i[new create edit update destroy]
    resource :relationships, only: %i[create destroy]
  end
  resources :posts, only: %i[index show] do
    resources :likes, only: %i[index create destroy], module: :posts
  end
end
