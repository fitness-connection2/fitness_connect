class PostCommentsController < ApplicationController

  def create
    post = Post.find(params[:post_id])
    if member_signed_in? #会員がログインしている場合
      comment = current_member.post_comments.new(post_comment_params) #コメントする会員が現在の会員の場合、コメントを保存
      comment.post_id = post.id
    elsif trainer_signed_in? #トレーナーがログインしている場合
      comment = current_trainer.post_comments.new(post_comment_params) #コメントするトレーナーが現在のトレーナーの場合、コメントを保存
      comment.post_id = post.id
    end
    comment.save
    redirect_to post_path(post.id)
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
