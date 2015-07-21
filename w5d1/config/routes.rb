Rails.application.routes.draw do
  resources :users, only: [:new, :create, :show] do
    resources :user_comments
  end
  resources :goals do
    resources :goal_comments
  end

  resource :session, only: [:new, :create, :destroy]

  root "goals#index"
end
