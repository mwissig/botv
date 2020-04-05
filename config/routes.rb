Rails.application.routes.draw do
    resources :comments do
      resources :comments
    end
  get 'videos/check'
  get 'videos/index'
  get 'videos/new'
  get 'videos/edit'
  get 'videos/show'
    resources :videos do
      resources :comments
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
    resources :videos do
      resources :comments
    end
end
end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
