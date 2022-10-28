class Public::RelationshipsController < ApplicationController

  def create
    if member_signed_in?
      current_member.follow(params[:member_id])
    elsif trainer_signed_in?
      current_trainer.follow(params[:trainer_id])
    end
      redirect_to request.referer
  end

  def destroy
    if member_signed_in?
      current_member.unfollow(params[:member_id])
    elsif trainer_signed_in?
      current_trainer.unfollow(params[:trainer_id])
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
