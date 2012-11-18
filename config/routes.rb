Tp::Application.routes.draw do
  resources :orders do 
    collection do 
      get :inventory
    end
  end
  resources :users
  root :to => 'pages#stripe'

end
