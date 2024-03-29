Rails.application.routes.draw do

  post :incoming, to: 'incoming#create'

  resources :topics do
    resources :bookmarks
  end

  resources :bookmarks, except: [:index] do
    resources :likes, only: [:index, :create, :destroy]
  end

  devise_for :users

  resources :users, only: [:show]

  get 'welcome/index'

  get 'welcome/about'

  root 'welcome#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
