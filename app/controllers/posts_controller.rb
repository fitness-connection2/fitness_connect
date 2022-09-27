class PostsController < ApplicationController
  before_action :authenticated_any

  def new
    @post = Post.new #空のモデル作成
  end

  def create
    @post = Post.new(post_params) #投稿データの保存
    @post.current_id = current_member.id | current_trainer.id
    @post.save
    redirect_to posts_path
  end

  def index
    @posts = Post.all
  end

  def show
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
