Rails.application.routes.draw do

#全員のルーティング設定(投稿
  post "/users/confirm" => "users#confirm"
  get "/users/edit" => "users#edit"
  get "/users" => "users#show"
  patch "/users/withdraw" => "users#withdraw"
  resources :users, only:[:update]
  resources :posts do
    resources :post_comments, only: [:create]
  end
  namespace :posts do
    resources :searches, only: :index
  end

#会員側のルーティング設定

#会員側のルーティング設定
  devise_for :members,skip: [:passwords], controllers: {
  registrations: "public/members/registrations",
  sessions: 'public/members/sessions'
}

#トレーナー側のルーティング設定
  devise_for :trainers,skip: [:passwords], controllers: {
  registrations: "public/trainers/registrations",
  sessions: 'public/trainers/sessions'
}

#管理者側ののルーティング設定

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
end