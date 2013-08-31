Ticketee::Application.routes.draw do
  root to: "projects#index"
  get "/signin", to: "sessions#new"
  post "/signin", to: "sessions#create"
  delete "/signout", to: "sessions#destroy", as: "signout"

  resources :projects do
    resources :tickets
  end

  resources :tickets do
    resources :comments
    resources :tags do
      member do
        delete :remove
      end
    end
  end

  resources :users
  resources :files

  namespace :admin do
    root to: "base#index"
    resources :users do
      resources :permissions

      put "permissions", to: "permissions#set", as: "set_permissions"
    end

    resources :states do
      member do
        get :make_default
      end
    end
  end
end
