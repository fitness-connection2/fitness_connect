require "test_helper"

class Admin::SubscriptionPlansControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_subscription_plans_index_url
    assert_response :success
  end

  test "should get edit" do
    get admin_subscription_plans_edit_url
    assert_response :success
  end
end
