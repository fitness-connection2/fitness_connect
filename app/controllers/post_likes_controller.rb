class PostLikesController < ApplicationController

  def create
    post = Post.find(params[:post_id])
    if member_signed_in? #会員がログインしている場合
      like = current_member.post_likes.new(post_id: post.id)
    elsif trainer_signed_in?
      like = current_tariner.post_likes.new(post_id: post.id)
    end
    like.save
    redirect_to post_path(post)
  end

  def destroy
    post = Post.find(params[:post_id])
    if member_signed_in?
      like = current_member.post_likes.find_by(post_id: post.id)
    elsif trainer_signed_in?
      like = current_tariner.post_likes.find_by(post_id: post.id)
    end
    like.destroy
    redirect_to post_path(post)
  end

end
