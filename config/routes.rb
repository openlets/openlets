OpenLets::Application.routes.draw do

  root :to => 'items#index'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks" }

  resources :users do
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

  get "pages/terms"
  get "pages/welcome"

end
