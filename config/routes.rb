Rails.application.routes.draw do

#全員のルーティング設定(投稿, 投稿検索, いいね機能、コメント機能

  get 'searches' => 'searches#index' #検索はネストせず単一で作成

#会員とトレーナーのルーティング設定(ユーザーページ)
  scope module: :public do
    devise_scope :member do
      root to: "members/sessions#new"
    end
    post "/members/confirm" => "members#confirm"
    get "/members/edit" => "members#edit"
    get "/members" => "members#show"
    patch "/members/withdraw" => "members#withdraw"

    post "/trainers/confirm" => "trainers#confirm"
    get "/trainers/edit" => "trainers#edit"
    get "/trainers" => "trainers#show"
    patch "/trainers/withdraw" => "trainers#withdraw"
    resources :members, only:[:update]
    resources :trainers, only:[:update]
  end

  resources :posts do
    resources :post_comments, only: [:create, :destroy]
    resource :post_likes, only: [:create, :destroy] #idを含める必要がないので単数形
  end

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
  namespace :admin do
    resources :members, only:[:index, :show, :edit, :update]
    resources :trainers, only:[:index, :show, :edit, :update]
  end
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
end