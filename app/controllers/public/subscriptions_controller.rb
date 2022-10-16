class Public::SubscriptionsController < ApplicationController
  before_action :authenticated_any

  def new
    @subscription = Subscription.new
  end

  def index
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def confirm
  end

  private

  def authenticated_any
    member_signed_in? | trainer_signed_in? #いずれかログインしている場合にビューに遷移可能
  end
end
