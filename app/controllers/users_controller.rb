class UsersController < ApplicationController
  def show
    if member_signed_in?
      @user = Member.find(params[:id])
      @posts = @member.posts
    elsif trainer_signed_in?
      @user = Trainer.find(params[:id])
      @posts = @trainer.posts
    end
  end

  def edit
  end

  def confirm
  end
end
