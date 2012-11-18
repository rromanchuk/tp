Tp::Application.routes.draw do
  resources :orders
  resources :users
  root :to => 'pages#stripe'

end
