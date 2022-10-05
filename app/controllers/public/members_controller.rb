class Public::MembersController < ApplicationController
  before_action :authenticated_any

  def show
    @member = Member.find(params[:id])
    @posts = @member.posts
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
    @member = Member.find(params[:id])
    @member = Member.update
    redirect_to member_path(@member.id)
  end

  def confirm
  end

  private

  def authenticated_any
    member_signed_in? || trainer_signed_in? #いずれかログインしている場合にビューに遷移可能
  end

  def member_params
    params.require(:member).permit(:profile_image, :name, :user_name, :telephone_number, :email, :introduction)
  end
end
