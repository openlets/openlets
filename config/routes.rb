OpenLets::Application.routes.draw do
  
  # constraints DomainConstraint.new do
  #   root to: 'pages#economy_home'
  # end

  root to: 'pages#home'

  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks", registrations: "registrations" }

  resources :economies

  resources :users do
    member do
      post 'direct_transfer'
      get  'transfer'
    end
  end

  resources :members do
    member do
      post 'direct_transfer'
      get  'transfer'
    end
  end
  
  resources :items do
    member do
      post 'purchase'
      put  'pause'
      put  'activate'
    end
    resources :comments, only: [:create]
  end
  
  resources :wishes do
    member do
      put  'pause'
      put  'activate'
      get  'fulfill'
      put  'close'
      post 'create_wish_offer'
    end
  end

  resources :conversations, only: [:index, :show] do
    resources :messages, only: [:create, :index]
    collection do
      get  '/:user_id/new',    to: 'conversations#new',    as: :new
      post '/:user_id/create', to: 'conversations#create', as: :create
    end
  end


  namespace :admin do
    root to: "admin#dashboard", as: :dashboard
    resources :economies
    resources :members do
      put :approve
      put :ban
    end
    resources :users do
      member do
        put :approve
        put :ban
      end
      collection do
        get 'managers'
        put 'add_manager'
        put 'add_admin'
        delete 'remove_manager'
        delete 'remove_admin'
      end      
    end
    resources :items
    resources :wishes
    resources :comments
    resources :settings do
      collection do
        get 'mass_edit'
        put 'mass_update'
      end
    end
    resources :transactions
    resources :categories
  end

  get "pages/terms"
  get "pages/welcome"

end