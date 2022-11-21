class Admin::PaymentsController < ApplicationController
 before_action :authenticate_admin!

  def index
    @payment = Payment.new
    @payments = Payment.all
  end

  def create
    @payment = Payment.new(payment_params)
    if @payment.save
      redirect_to admin_payments_path
      flash[:notice] = "支払い方法を登録しました。"
    else
      @payments = Payment.all
      render :index
    end
  end

  def edit
    @payment = Payment.find(params[:id])
  end

  def update
    @payment = Payment.find(params[:id])
    if @payment.update(payment_params)
      redirect_to admin_payments_path
      flash[:notice] = "支払い方法を更新しました。"
    else
      render :edit
    end
  end

  private

  def payment_params
    params.require(:payment).permit(:payment_method)
  end
end
