NewsReader::Application.routes.draw do
  namespace :api do
    get "feeds/:id/reload", to: "feeds#reload"
    resources :feeds, only: [:index, :create, :show, :destroy] do
      resources :entries, only: [:index]
    end
  end

  root to: "static_pages#index"
end
