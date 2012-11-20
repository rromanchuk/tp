Tp::Application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :orders do 
    collection do 
      get :inventory
    end
  end
  resources :users
  resources :token_authentications, :only => [:create, :destroy]

  root :to => 'orders#index'

end
