Tp::Application.routes.draw do
  resources :orders
  
  root :to => 'pages#stripe'

end
