Rails.application.routes.draw do

#全員のルーティング設定(投稿, 投稿検索, いいね機能、コメント機能

  get "/subscriptions/:trainer_id/new" => "subscriptions#new", as: "subscriptions_new"
  post "/subscriptions/confirm" => "subscriptions#confirm"
  get 'searches' => 'searches#index' #検索はネストせず単一で作成
  get "/subscription" => "subscriptions#show" #idを含める必要がないので単一で記述
  delete "/subscriptions/:id" => "subscriptions#destroy", as: "subscriptions_destroy"
  resources :subscriptions, only:[:create, :index, :show, :edit, :update]
  resources :posts do
    resources :post_comments, only: [:create, :destroy]
    resource :post_likes, only: [:create, :index, :destroy] #idを含める必要がないので単数形
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

#会員とトレーナーのルーティング設定(ユーザーページ)
  scope module: :public do
    devise_scope :member do
      root to: "members/sessions#new"
    end

    patch "/members/withdraw" => "members#withdraw"
    patch "/trainers/withdraw" => "trainers#withdraw"
    get "/members/confirm" => "members#confirm"
    get "/trainers/confirm" => "trainers#confirm"
    resources :members, only:[:show, :edit, :update] do
      resource :relationships, only: [:create, :destroy]
      member do
        get :followings
        get :followers
        get :post_likes
        get :new_notifications
      end
    end
    resources :trainers, only:[:show, :edit, :update] do
      resource :relationships, only: [:create, :destroy]
      member do
        get :followings
        get :followers
        get :post_likes
        get :new_notifications
      end
    end
  end

#管理者側ののルーティング設定
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
  namespace :admin do
    resources :members, only:[:index, :show, :edit, :update]
    resources :trainers, only:[:index, :show, :edit, :update]
    resources :subscription_plans, only:[:create, :index, :edit, :update, :destroy]
    resources :payments, only:[:create, :index, :edit, :update, :destroy]
  end
end