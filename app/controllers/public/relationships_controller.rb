class Public::RelationshipsController < ApplicationController
  before_action :authenticated_any

  def create
    if trainer_to_member?
      current_trainer.follow_member(params[:member_id])
    elsif trainer_to_trainer?
      current_trainer.follow_trainer(params[:trainer_id])
    elsif member_to_member?
      current_member.follow_member(params[:member_id])
    elsif member_to_trainer?
      current_member.follow_trainer(params[:trainer_id])
    end

    redirect_to request.referer
  end

  def destroy
    if trainer_to_member?
      current_trainer.unfollow_member(params[:member_id])
    elsif trainer_to_trainer?
      current_trainer.unfollow_trainer(params[:trainer_id])
    elsif member_to_member?
      current_member.unfollow_member(params[:member_id])
    elsif member_to_trainer?
      current_member.unfollow_trainer(params[:trainer_id])
    end

    redirect_to request.referer
  end

  private

  def trainer_to_member?
    params[:follower_type] == "trainer" && params[:member_id].present?
  end

  def trainer_to_trainer?
    params[:follower_type] == "trainer" && params[:trainer_id].present?
  end

  def member_to_member?
    params[:follower_type] == "member" && params[:member_id].present?
  end

  def member_to_trainer?
    params[:follower_type] == "member" && params[:trainer_id].present?
  end

  def authenticated_any
    unless member_signed_in? || trainer_signed_in? #いずれかログインしている場合にビューに遷移可能
      redirect_to posts_path, notice: "ログインが必要です。"
    end
  end

end
