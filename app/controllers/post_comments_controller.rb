class PostCommentsController < ApplicationController

  def create
    post = Post.find(params[:post_id])
    if member_signed_in? #会員がログインしている場合
      comment = current_member.post_comments.new(post_comment_params) #コメントする会員が現在の会員の場合、コメントを保存
      comment.post_id = post.id
      action_type = Notification.action_types[:commented_on_the_post_member_to_trainer] #会員からトレーナーへのコメント通知
      member = current_member
      trainer = post.trainer
    elsif trainer_signed_in? #トレーナーがログインしている場合
      comment = current_trainer.post_comments.new(post_comment_params) #コメントするトレーナーが現在のトレーナーの場合、コメントを保存
      comment.post_id = post.id
      action_type = Notification.action_types[:commented_on_the_post_trainer_to_member] #トレーナーから会員へのいいね通知
      member = post.member
      trainer = current_trainer
    end
    comment.save
    create_notifications(post, member, trainer, action_type)
    redirect_to post_path(post.id)
  end

  def destroy
    PostComment.find(params[:id]).destroy
    redirect_to post_path(params[:post_id])
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

  def create_notifications(post, member, trainer, action_type)
    Notification.create!(subject_id: post.id, subject_type: "posts", member_id: member.id, trainer_id: trainer.id, action_type: action_type)
  end
end
