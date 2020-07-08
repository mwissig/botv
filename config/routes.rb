Rails.application.routes.draw do





  get 'flags/toggleflag'
  get 'pages/togglemod'



  get 'users/:id/videos' => 'users#videos'
  get 'users/:id/playlists' => 'users#playlists'
  get 'users/:id/comments' => 'users#comments'
  get 'users/:id/stats' => 'users#stats'
  get 'users/:id/bulbs' => 'users#bulbs'
  get 'users/:id/bulbs/given' => 'users#bulbsgiven'
  get 'users/:id/bulbs/received' => 'users#bulbstaken'

  get 'notifications/markread'
  get 'notifications/markallread'
  get 'notifications/tomod'
  get 'notifications/frommod'
  resources :notifications

get 'inbox' => 'notifications#index'

  get 'videos/search'
  get 'contact' => 'pages#contact'
  get 'privacy' => 'pages#privacy'
  get 'playlists/createplaylist'
  get 'newplaylist' => 'playlists#createplaylist'
  get 'addtoplaylist' => 'playlists#addtoplaylist'
  get 'sources' => 'pages#sources'

  get 'permissions/togglensfw'
  get 'nsfw' => 'videos#nsfw'
  get 'categories' => 'pages#twocats'
  get 'category' => 'pages#category'

  get 'top/viewed'
  get 'top/loved'
  get 'top/hated'
  get 'top/controversial'
  get 'top/playlists/loved' => 'top#lovedplaylists'
  get 'top/playlists/viewed' => 'top#viewedplaylists'
  get 'top/week/loved' => 'top#lovedweek'
  get 'top/week/hated' =>'top#hatedweek'
  get 'top/month/loved' => 'top#lovedmonth'
  get 'top/month/hated' => 'top#hatedmonth'
  get 'top/week/viewed' => 'top#viewedweek'
  get 'top/month/viewed' => 'top#viewedmonth'
  get 'top/week/controversial' => 'top#controweek'
  get 'top/month/controversial' => 'top#contromonth'
  get 'top/hot'

  get 'rules' => 'pages#rules'
  get 'mod' => 'pages#mod'
    get 'admin' => 'pages#admin'
  get 'bans/mod'
  get 'bans/index'

  get 'users/show'
  get 'videos/tags'

    resources :comments do
      resources :comments
      resources :bulbs
          resources :flags
    end

    resources :playlists do
      resources :comments
      resources :bulbs
          resources :flags
      resources :items do
        resources :videos
      end
    end

  get 'videos/check'
  get 'videos/index'
  get 'videos/new'
  get 'videos/edit'
  get 'videos/show'

    resources :videos do
      resources :comments
      resources :bulbs
          resources :flags
    end

  get 'recent' => 'pages#recent'
  get 'rank/asc' => 'pages#asc'
  get 'rank/desc' => 'pages#desc'
  resources :statuses
  root 'pages#home'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  resources :users do
    resources :statuses
    resources :permissions
  resources :notifications
  resources :bulbs
end
end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
