class Public::MembersController < ApplicationController
  before_action :authenticated_any

  def show
    @member = Member.find(params[:id])
    @posts = @member.posts
    @subscription = @member.subscription
    Relationship.find_by(id: params[:relationship_id])&.update(is_read: true) if @member == current_member
  end

  def edit
    @member = Member.find(params[:id])
      unless @member == current_member #現在の会員以外はマイページ編集不可
      redirect_to member_path(current_member)
      end
  end

  def update
    @member = Member.find(params[:id]) #今回は会員idがあるので、current_memberではない
    if @member.update(member_params)
      redirect_to member_path(@member.id)
    else
      render :edit
    end
  end

  def confirm
    @member = current_member
  end

  def withdraw
    @member = current_member　#退会するのは現在の会員以外ないので、current_userでok
    @member.update(is_delete: true)
    reset_session
    redirect_to root_path
  end

  def post_likes
    @member = Member.find(params[:id]) #会員のidデータの取得
    @likes = PostLike.where(member_id: @member.id) #上記該当する会員のいいねのレコードを代入
  end

  def followings #フォロー一覧ページ用
    @member = Member.find(params[:member_id])
    @users = @member.get_following_users
  end

  def followers
    @member = Member.find(params[:member_id])
    @users = @member.get_followed_users
  end

  # def new_post_likes
  #   @member = Member.find(params[:id])
  #   @post_likes = @member.new_liked
  #   render 'public/shared/new_post_likes'
  # end

  # def new_post_comments
  #   @member = Member.find(params[:id])
  #   @post_comments = @member.new_commented
  #   render 'public/shared/new_post_comments'
  # end

  # def new_relationships
  #   @member = Member.find(params[:id])
  #   @relationships = @member.new_followed
  #   render 'public/shared/new_relationships'
  # end

  def new_notifications
    @member = Member.find(params[:id])
    @post_likes = @member.new_liked
    @post_comments = @member.new_commented
    @relationships = @member.new_followed
    render 'public/shared/new_notifications' #Turbolinksを解除すると戻るで更新
  end

  private

  def authenticated_any
    unless member_signed_in? || trainer_signed_in? #いずれかログインしている場合にビューに遷移可能
      flash[:notice] = "ログインが必要です。"
      redirect_to posts_path
    end
  end

  def member_params
    params.require(:member).permit(:profile_image, :name, :user_name, :telephone_number, :email, :introduction, :is_deleted, :subscription_id)
  end
end
