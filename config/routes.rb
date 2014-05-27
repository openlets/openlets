OpenLets::Application.routes.draw do

  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks", registrations: "registrations" }

  resources :economies

  resources :users do
    member do
      post :direct_transfer
      get  :transfer
    end
  end

  resources :members do
    member do
      post :direct_transfer
      get  :transfer
    end
  end
  
  resources :items do
    member do
      get  :purchase_details
      post :time_purchase
      post :purchase
      put  :pause
      put  :activate
    end
    resources :comments, only: [:create]
  end
  
  resources :wishes do
    member do
      put  :pause
      put  :activate
      get  :fulfill
      put  :close
      post :create_wish_offer
    end
  end

  resources :conversations, only: [:index, :show] do
    resources :messages, only: [:create, :index]
    collection do
      get  '/:user_id/new',    to: 'conversations#new',    as: :new
      post '/:user_id/create', to: 'conversations#create', as: :create
    end
  end

  constraints DomainConstraint.new do
    root to: 'pages#economy_home'

    namespace :admin do
      root to: "admin#dashboard", as: :dashboard
      resources :members do
        put :approve
        put :ban
      end
      resources :users do
        member do
          put :approve
          put :ban
        end    
      end
      resources :managers do
        collection do
          put 'add'
          delete 'remove'
        end 
      end
      resources :items do
        member do
          put :activate
          put :pause
          put :ban
        end
      end
      resources :wishes
      resources :comments
      resources :settings do
        collection do
          get :mass_edit
          put :mass_update
        end
      end
      resources :transactions do
        member do
          put :cancel
        end
      end
      resources :categories
      resources :economies, only: :update
    end

  end

  namespace :realm do
    root to: "realm#dashboard", as: :dashboard
    
    resources :admins do
      collection do
        put    :add
        delete :remove
      end      
    end

    resources :users
    resources :economies
  end

  get "pages/terms"
  get "pages/welcome"

  root to: 'pages#home'
end