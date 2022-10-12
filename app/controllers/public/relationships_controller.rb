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

  def followings
    member = Member.find(params[:member_id])
    @members = member.followings
  end

  def followers
    member = Member.find(params[:member_id])
    @members = member.followers
  end
end
