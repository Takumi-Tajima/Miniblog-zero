Rails.application.routes.draw do
  root 'posts#index'
  devise_for :users
  scope module: :usre do
    resources :posts, only: %i[new create edit update destory]
  end
  resources :posts, only: %i[index show]
end
