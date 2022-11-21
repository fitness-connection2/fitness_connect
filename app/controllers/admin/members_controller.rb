class Admin::MembersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @members = Member.all
  end

  def show
    @member = Member.find(params[:id])
    @posts = @member.posts
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
    @member = Member.find(params[:id])
    if @member.update(member_params)
      redirect_to edit_admin_member_path
      flash[:notice] = "情報を更新しました。"
    else
      render :edit
    end
  end

  private

  def member_params
   params.require(:member).permit(:member_id, :name, :user_name, :email, :telephone_number, :is_delete)
  end
end
