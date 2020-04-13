Rails.application.routes.draw do

  get 'permissions/togglensfw'
  get 'nsfw' => 'videos#nsfw'
  get 'categories' => 'pages#twocats'
  get 'category' => 'pages#category'
  get 'top/viewed'
  get 'top/loved'
  get 'top/hated'
  get 'top/controversial'
  get 'rules' => 'pages#laws'
  get 'mod' => 'pages#mod'
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
