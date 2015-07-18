Rails.application.routes.draw do

  resources :users, only: [:create, :new]
  resource :session, only: [:create, :new, :destroy]

  resources :subs do
    resources :posts, only: [:new]
    resources :mod_subs, only: [:create, :destroy, :new]
  end
  resources :posts, except: [:index, :new] do
    resources :comments, only: [:new, :create]
  end
  
  root "subs#index"
end
