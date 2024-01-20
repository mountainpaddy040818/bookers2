Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:create, :index, :show, :edit, :update]
  root 'homes#top'
  resources :books, only: [:new, :create, :index, :show, :edit, :destroy, :update]
  get '/home/about' => 'homes#about', as: "about"
  get 'users' => 'users#index'
  # get 'home/about'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
