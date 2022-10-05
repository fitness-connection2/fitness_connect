class Public::TrainersController < ApplicationController
  before_action :authenticated_any
  
  def show
    @trainer = Trainer.find(params[:id])
    @posts = @trainer.posts
  end

  def edit
  end

  def confirm
  end

  private
  
  def authenticated_any
    member_signed_in? || trainer_signed_in? #いずれかログインしている場合にビューに遷移可能
  end

  def trainer_params
    params.require(:trainer).permit(:profile_image, :name, :user_name, :telephone_number, :email, :introduction)
  end
end
