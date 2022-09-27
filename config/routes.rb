Rails.application.routes.draw do

#全員のルーティング設定(投稿
  resources :posts

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