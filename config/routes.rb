Rails.application.routes.draw do
  devise_for :users
  root 'users#index'
  resources :users, only: [:index, :show] do
    resources :posts do
      resources :comments
      resources :likes
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
