class Public::SubscriptionsController < ApplicationController
  before_action :authenticated_any

  def new
    @subscription = Subscription.new
    @subscription_plans = SubscriptionPlan.all
    @payments = Payment.all
  end

  def confirm
    @subscription = Subscription.new(subscription_params) #newで作成されたカラム情報を一時的に保存
    @subscription.member_id = current_member.id
  end

  def create
    @subscription = Subscription.new(subscription_params)
    @subscription.member_id = current_member.id
    @subscription.save
    redirect_to subscription_path(@subscription)
  end

  def index
  end

  def show
    @subscription = Subscription.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def authenticated_any
    member_signed_in? | trainer_signed_in? #いずれかログインしている場合にビューに遷移可能
  end

  def subscription_params
    params.require(:subscription).permit(:period, :payment_id, :subscription_plan_id)
  end
end
