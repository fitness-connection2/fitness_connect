class Public::RelationshipsController < ApplicationController

  def create
    if member_signed_in?
      current_member.follow(params[:member_id])
      action_type = Notification.action_types[:followed_member] #会員から会員へのフォロー通知
      member = current_member
    elsif trainer_signed_in?
      current_trainer.follow(params[:trainer_id])
      action_type = Notification.action_types[:followed_trainer] #トレーナーからトレーナーへのフォロー通知
      trainer = current_trainer
    end
      create_notifications(relationship, member, trainer, action_type)
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

  def create_notifications(relationship, member, trainer, action_type)
    Notification.create!(subject_id: relationship.id, subject_type: "relationships", member_id: member.id, trainer_id: trainer.id, action_type: action_type)
  end

end
