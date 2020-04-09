Rails.application.routes.draw do

  get 'bans/mod'
  get 'bans/index'

  get 'users/show'
  get 'videos/tags'
    resources :comments do
      resources :comments
        resources :bulbs
    end
  get 'videos/check'
  get 'videos/index'
  get 'videos/new'
  get 'videos/edit'
  get 'videos/show'
    resources :videos do
      resources :comments
        resources :bulbs
    end
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
    resources :permissions
end
end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
