Rails.application.routes.draw do
  get 'recent' => 'pages#recent'
  get 'rank/asc' => 'pages#asc'
  get 'rank/desc' => 'pages#desc'
  resources :statuses
  root 'pages#home'
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  resources :users do
  resources :statuses
end
end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
