require "test_helper"

class Public::SubscriptionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get public_subscriptions_new_url
    assert_response :success
  end

  test "should get index" do
    get public_subscriptions_index_url
    assert_response :success
  end

  test "should get show" do
    get public_subscriptions_show_url
    assert_response :success
  end

  test "should get edit" do
    get public_subscriptions_edit_url
    assert_response :success
  end

  test "should get confirm" do
    get public_subscriptions_confirm_url
    assert_response :success
  end
end
