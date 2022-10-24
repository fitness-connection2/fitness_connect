class PostLikesController < ApplicationController

  def create
    post = Post.find(params[:post_id])
    if member_signed_in? #会員がログインしている場合
      like = current_member.post_likes.new(post_id: post.id)
      action_type = Notification.action_types[:liked_the_post_member_to_trainer] #会員からトレーナーへのいいね通知
      member = current_member
      trainer = post.trainer
    elsif trainer_signed_in?
      like = current_trainer.post_likes.new(post_id: post.id)
      action_type = Notification.action_types[:liked_the_post_trainer_to_member] #トレーナーから会員へのいいね通知
      member = post.member
      trainer = current_trainer
    end
    like.save
    create_notifications(post, member, trainer, action_type)
    redirect_to post_path(post)
  end

  def destroy
    post = Post.find(params[:post_id])
    if member_signed_in?
      like = current_member.post_likes.find_by(post_id: post.id)
    elsif trainer_signed_in?
      like = current_trainer.post_likes.find_by(post_id: post.id)
    end
    like.destroy
    redirect_to post_path(post)
  end

  private

  def create_notifications(post, member, trainer, action_type)
    Notification.create!(subject_id: post.id, subject_type: "posts", member_id: member.id, trainer_id: trainer.id, action_type: action_type)
  end
end
