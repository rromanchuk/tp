Tp::Application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :orders do 
    collection do 
      get :inventory
    end
  end
  resource :system do 
    collection do
      get :environment
    end
  end

  namespace :admin do 
    resources :pages 
  end

  resources :users
  resources :token_authentications, :only => [:create, :destroy]

  root :to => 'pages#landing'

end
