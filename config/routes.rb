Rails.application.routes.draw do
  namespace :public do
    namespace :trainers do
      get 'posts/new'
      get 'posts/index'
      get 'posts/show'
      get 'posts/edit'
    end
  end
  namespace :public do
    namespace :members do
      get 'posts/new'
      get 'posts/index'
      get 'posts/show'
      get 'posts/edit'
    end
  end
  scope module: :public do

    namespace :trainers do
    resources :posts, only:[:new, :index, :show, :edit]
    end
#会員側のルーティング設定
    namespace :members do
    resources :posts, only:[:new, :index, :show, :edit]
    end
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
    resources :posts, only:[:index, :show]
  end

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
end