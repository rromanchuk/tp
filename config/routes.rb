Tp::Application.routes.draw do
  devise_for :users
  namespace :api do
    devise_for :users
  end  
  resources :tokens
  
  root :to => 'pages#stripe'

end
