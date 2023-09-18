Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/edit'
  get   'sessions/new'
  root  "static_pages#home"
  get   "/help",    to: "static_pages#help"
  get   "/about",   to: "static_pages#about"
  get   "/contact", to: "static_pages#contact"
  get   "/signup",  to: "users#new"
  get   "/login",   to: "sessions#new"
  post   "/login",   to: "sessions#create"
  delete  "/logout",   to: "sessions#destory"
  resources :users #ユーザー情報取得のさまざまなメソッドなどを使えるようにする
  resources :account_activations, only: [:edit] #アカウント有効化のためのリソース

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
