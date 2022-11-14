class Public::RelationshipsController < ApplicationController

  def create
    if current_member #現在の会員の場合
      if params[:target].to_i == 0 #ターゲットがトレーナーの場合
        current_member.follow(params[:trainer_id], params[:target] ) #会員がトレーナーをフォロー
      else #ターゲットがトレーナー以外の場合
      #byebug
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

  def followings #フォロー一覧ページ用
    if member_signed_in?
      member = Member.find(params[:member_id])
      @members = member.followings
    elsif trainer_signed_in
      trainer = Trainer.find(params[:trainer_id])
      @trainers = trainer.followings
    end
  end

  def followers #フォロワー一覧ページ用
    if member_signed_in
      member = Member.find(params[:member_id])
      @members = member.followers
    elsif trainer_signed_in
      trainer = Trainer.find(params[:trainer_id])
      @trainers = trainer.followers
    end
  end

  private

end
