class PostLikesController < ApplicationController
  before_action :authenticated_any

  def create
    post = Post.find(params[:post_id]) #postの全ての情報を取得
    if member_signed_in? #会員がログインしている場合
      like = current_member.post_likes.new(post_id: post.id) #postのidのみを入れる
    elsif trainer_signed_in?
      like = current_trainer.post_likes.new(post_id: post.id)
    end
    like.save
    redirect_to post_path(post)
  end

  def destroy
    post = Post.find(params[:post_id]) #主キーの取得
    if member_signed_in?
      like = current_member.post_likes.find_by(post_id: post.id) #主キー以外のカラム内容を
    elsif trainer_signed_in?
      like = current_trainer.post_likes.find_by(post_id: post.id)
    end
    like.destroy
    redirect_to post_path(post)
  end

  private

  def authenticated_any
    unless member_signed_in? | admin_signed_in? | trainer_signed_in? #いずれかログインしている場合にビューに遷移可能
      flash[:notice] = "ログインが必要です。"
      redirect_to posts_path
    end
  end

end
