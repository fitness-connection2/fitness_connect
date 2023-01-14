class PostCommentsController < ApplicationController
  before_action :authenticated_any

  def create
    post = Post.find(params[:post_id])
    if member_signed_in? #会員がログインしている場合
      comment = current_member.post_comments.new(post_comment_params) #コメントする会員が現在の会員の場合、コメントを保存
      comment.post_id = post.id
    elsif trainer_signed_in? #トレーナーがログインしている場合
      comment = current_trainer.post_comments.new(post_comment_params) #コメントするトレーナーが現在のトレーナーの場合、コメントを保存
      comment.post_id = post.id
    end
    if comment.save
      redirect_to post_path(post.id)
    else
      flash[:notice] = "コメントを入力してください"
      redirect_to post_path(post.id)
    end
  end

  def destroy
    PostComment.find(params[:id]).destroy
    redirect_to post_path(params[:post_id])
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

  def authenticated_any
    unless member_signed_in? | admin_signed_in? | trainer_signed_in? #いずれかログインしている場合にビューに遷移可能
      redirect_to posts_path
    end
  end
end
