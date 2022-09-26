class Public::Members::PostsController < ApplicationController
  before_action :authenticate_member!

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post_current_id = current_member.id
    @post.save
    redirect_to members_posts_path
  end

  def index
  end

  def show
  end

  def edit
  end
  private

  def post_params
    params.require(:post).permit(:image, :description)
  end
end
