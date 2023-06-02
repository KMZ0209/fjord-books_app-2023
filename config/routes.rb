Rails.application.routes.draw do
  devise_for :users
  resources :books

  # usersに対してindexとshowアクションのみを許可する
  resources :users, only: %i(index show)

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  # ルートルーティングを設定
  root to: 'books#index'

  # 一番下に追加する
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
