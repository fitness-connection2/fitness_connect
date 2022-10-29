class PostsController < ApplicationController
  before_action :authenticated_any

  def new
    @post = Post.new #空のモデル作成
  end

  def create
    @post = Post.new(post_params) #投稿データの保存
    if member_signed_in? #会員がログインしている場合
      @post.member_id = current_member.id
    elsif trainer_signed_in? #トレーナーがログインしている場合
      @post.trainer_id = current_trainer.id
    else
      render :new
    end
    @post.save
    redirect_to posts_path
  end

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
    PostLike.find_by(id: params[:post_like_id])&.update(is_read: true) if @post.member == current_member || @post.trainer == current_trainer
    PostComment.find_by(id: params[:post_comment_id])&.update(is_read: true) if @post.member == current_member || @post.trainer == current_trainer
    #Relationship.find_by(id: params[:relationship_id])&.update(is_read: true) if @relationship.member == current_member || @relationship.trainer == current_trainer
    redirect_to posts_path, notice: 'この記事は参照できません。' if @post.enable_post? #削除されたユーザーの投稿詳細を非公開
  end

  def edit
    @post = Post.find(params[:id])
    if @post.member == current_member
    elsif @post.trainer == current_trainer
      render :edit
    else
      redirect_to posts_path
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "更新が完了しました。"
      redirect_to post_path(@post.id)
    else
      render :edit
    end
  end

  private

  def authenticated_any
    member_signed_in? | admin_signed_in? | trainer_signed_in? #いずれかログインしている場合にビューに遷移可能
  end

  def post_params
    params.require(:post).permit(:image, :description, :trainer_id)
  end
end
