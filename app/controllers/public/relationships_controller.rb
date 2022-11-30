class Public::RelationshipsController < ApplicationController
  before_action :authenticated_any

  def create
    if current_member #現在の会員の場合
      if params[:target].to_i == 0 #ターゲットがトレーナーの場合
        current_member.follow(params[:trainer_id], params[:target] ) #会員がトレーナーをフォロー
      else #ターゲットがトレーナー以外の場合
        current_member.follow(params[:member_id], params[:target] ) #会員が会員をフォロー
      end
    else #現在の会員以外の場合
      if params[:target].to_i == 0 #ターゲットがトレーナーの場合
        current_trainer.follow(params[:trainer_id], params[:target] ) #トレーナーがトレーナーをフォロー
      else #ターゲットがトレーナー以外の場合
        current_trainer.follow(params[:member_id], params[:target] ) #トレーナーが会員をフォロー
      end
    end
    redirect_to request.referer
  end

  def destroy
    if current_member
      if params[:target].to_i == 0
        current_member.unfollow(params[:trainer_id], params[:target] )
      else
        current_member.unfollow(params[:member_id], params[:target] )
      end
    else
      if params[:target].to_i == 0
        current_trainer.unfollow(params[:trainer_id], params[:target] )
      else
        current_trainer.unfollow(params[:member_id], params[:target] )
      end
    end
    redirect_to request.referer
  end

  private

  def authenticated_any
    unless member_signed_in? || trainer_signed_in? #いずれかログインしている場合にビューに遷移可能
      flash[:notice] = "ログインが必要です。"
      redirect_to posts_path
    end
  end

end
