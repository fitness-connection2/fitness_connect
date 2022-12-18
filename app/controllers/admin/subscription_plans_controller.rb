class Admin::SubscriptionPlansController < ApplicationController
 before_action :authenticate_admin!

  def index
    @subscription_plan = SubscriptionPlan.new
    @subscription_plans = SubscriptionPlan.all
  end

  def create
    @subscription_plan = SubscriptionPlan.new(subscription_plan_params)
    if @subscription_plan.save
      redirect_to admin_subscription_plans_path
      flash[:notice] = "新しいプランを登録しました。"
    else
      @subscription_plans = SubscriptionPlan.all
      render :index
    end
  end

  def edit
    @subscription_plan = SubscriptionPlan.find(params[:id])
  end

  def update
    @subscription_plan = SubscriptionPlan.find(params[:id])
    if @subscription_plan.update(subscription_plan_params)
      redirect_to admin_subscription_plans_path
      flash[:notice] = "プランを更新しました。"
    else
      render :edit
    end
  end

  private

  def subscription_plan_params
    params.require(:subscription_plan).permit(:plan, :price, :payment_method, :period)
  end

end
