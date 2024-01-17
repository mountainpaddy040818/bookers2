Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show, :edit, :update]
  root to: 'homes#top'
  resources :books
  get '/homes/about' => 'homes#about', as: "about"
  get 'users' => 'users#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
