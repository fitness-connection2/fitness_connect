Rails.application.routes.draw do

#全員のルーティング設定(投稿, 投稿検索, いいね機能、コメント機能

  get 'searches' => 'searches#index' #検索はネストせず単一で作成
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
    post "/members/confirm" => "members#confirm"
    post "/trainers/confirm" => "trainers#confirm"
    post "/subscriptions/confirm" => "subscriptions#confirm"
    resources :members, only:[:show, :edit, :update] do
      resource :relationships, only: [:create, :destroy]
      get "followings" => "relationships#followings", as: "followings"
      get "followers" => "relationships#create", as: "followers"
      member do
        get :post_likes
      end
    end
    resources :trainers, only:[:show, :edit, :update] do
      resource :relationships, only: [:create, :destroy]
      get "followings" => "relationships#followings", as: "followings"
      get "followers" => "relationships#create", as: "followers"
      member do
        get :post_likes
      end
    end
    resources :subscriptions, only:[:new, :create, :show, :index, :edit, :update, :destroy]
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