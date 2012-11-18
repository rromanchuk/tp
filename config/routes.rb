Tp::Application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :orders do 
    collection do 
      get :inventory
    end
  end
  resources :users
  root :to => 'orders#index'

end
