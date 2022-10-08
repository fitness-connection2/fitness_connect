class Public::TrainersController < ApplicationController
  before_action :authenticated_any

  def show
    @trainer = Trainer.find(params[:id])
    @posts = @trainer.posts
  end

  def edit
   @trainer = Trainer.find(params[:id])
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
    @trainer = current_member
  end

  def withdraw
    @trainer = Trainer.find(params[:id])
    @trainer.update(is_delete: true)
    reset_session
    redirect_to root_path
  end

  private

  def authenticated_any
    member_signed_in? || trainer_signed_in? #いずれかログインしている場合にビューに遷移可能
  end

  def trainer_params
    params.require(:trainer).permit(:profile_image, :name, :user_name, :telephone_number, :email, :introduction, :is_deleted)
  end
end
