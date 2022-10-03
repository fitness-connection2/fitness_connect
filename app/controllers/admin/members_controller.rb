class Admin::MembersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @members = Member.all
  end

  def show
    @member = Member.find(params[:id])
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to admin_members_path
    else
      render :edit
    end
  end

  private

  def member_params
   params.require(:member).permit(:member_id, :name, :user_name, :email, :telephone_number, :is_delete)
  end
end
