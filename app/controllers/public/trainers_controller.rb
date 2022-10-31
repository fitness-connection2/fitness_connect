class Public::TrainersController < ApplicationController
  before_action :authenticated_any

  def show
    @trainer = Trainer.find(params[:id])
    @posts = @trainer.posts
    Relationship.find_by(id: params[:relationship_id])&.update(is_read: true) if @trainer == current_trainer
  end

  def edit
   @trainer = Trainer.find(params[:id])
      unless @trainer == current_trainer #現在のトレーナー以外はマイページ編集不可
      redirect_to trainer_path(current_trainer)
      end
  end

  def update
    @trainer = Trainer.find(params[:id])
    if @trainer.update(trainer_params)
      redirect_to trainer_path(@trainer.id)
    else
      render :edit
    end
  end

  def confirm
    @trainer = current_trainer
  end

  def withdraw
    @trainer = current_trainer
    @trainer.update(is_delete: true)
    reset_session
    redirect_to root_path
  end

  def post_likes
    @trainer = Trainer.find(params[:id]) #トレーナーのidを取得
    @likes = PostLike.where(trainer_id: @trainer.id) ##上記該当するトレーナーのいいねのレコードを代入
  end

  # def new_post_likes
  #   @trainer = Trainer.find(params[:id])
  #   @post_likes = @trainer.new_liked
  #   render 'public/shared/new_post_likes'
  # end

  # def new_post_comments
  #   @trainer = Trainer.find(params[:id])
  #   @post_comments = @trainer.new_commented
  #   render 'public/shared/new_post_comments'
  # end

  # def new_relationships
  #   @trainer = Trainer.find(params[:id])
  #   @relationships = @trainer.new_followed
  #   render 'public/shared/new_relationships'
  # end

  # def new_subscriptions
  #   @trainer = Trainer.find(params[:id])
  #   @subscriptions = @trainer.new_subscribed
  #   render 'public/shared/new_subscriptions'
  # end

  def new_notifications
    @trainer = Trainer.find(params[:id])
    @post_likes = @trainer.new_liked
    @post_comments = @trainer.new_commented
    @relationships = @trainer.new_followed
    @subscriptions = @trainer.new_subscribed
    render 'public/shared/new_notifications' #Turbolinksを解除すると戻るで更新
  end

  private

  def authenticated_any
    member_signed_in? || trainer_signed_in? #いずれかログインしている場合にビューに遷移可能
  end

  def trainer_params
    params.require(:trainer).permit(:profile_image, :name, :user_name, :telephone_number, :email, :introduction, :is_deleted)
  end
end
