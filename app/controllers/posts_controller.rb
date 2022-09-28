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
  end

  def edit
  end

  private

  def authenticated_any
    member_signed_in? | admin_signed_in? | trainer_signed_in? #いずれかログインしている場合にビューに遷移可能
  end

  def post_params
    params.require(:post).permit(:image, :description)
  end
end
