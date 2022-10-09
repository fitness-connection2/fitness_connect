class Admin::TrainersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @trainers = Trainer.all
  end

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
      redirect_to admin_trainers_path
    else
      render :edit
    end
  end

  private

  def trainer_params
   params.require(:trainer).permit(:trainer_id, :name, :user_name, :email, :telephone_number, :is_delete)
  end
end