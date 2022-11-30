class SubscriptionsController < ApplicationController
  before_action :authenticated_any

  def new
    if member_signed_in?
      @subscription = Subscription.new
      @subscription_plans = SubscriptionPlan.all
      @payments = Payment.all
      @trainer = Trainer.find(params[:trainer_id])
    else
      redirect_to subscription_path(subscription.id)
    end
  end

  def confirm
    @subscription = Subscription.new(subscription_params) #newで作成されたカラム情報を一時的に保存
    @subscription.member_id = current_member.id
  end

  def create
    @subscription = Subscription.new(subscription_params)
    @subscription.member_id = current_member.id
    @subscription.save
    flash[:notice] = "サブスクを登録しました。"
    redirect_to subscription_path(@subscription)
  end

  def index
    if trainer_signed_in?
      @subscriptions = current_trainer.subscriptions
      Subscription.update(is_read: true)
    else
      redirect_to posts_path
    end
  end

  def show
    if member_signed_in?
      @subscription = current_member.subscription
    end
  end

  def edit
  end

  def update
  end

  def destroy
    @subscription = Subscription.find(params[:id])
    @subscription.destroy
    if member_signed_in?
      flash[:notice] = "サブスクを削除しました。"
      redirect_to member_path(current_member)
    elsif trainer_signed_in?
      flash[:notice] = "サブスクを削除しました。"
      redirect_to trainer_path(current_trainer)
    end
  end

  private

  def authenticated_any
    unless member_signed_in? | admin_signed_in? | trainer_signed_in? #いずれかログインしている場合にビューに遷移可能
      flash[:notice] = "ログインが必要です。"
      redirect_to posts_path
    end
  end

  def subscription_params
    params.require(:subscription).permit(:period, :payment_id, :subscription_plan_id, :trainer_id)
  end

end
