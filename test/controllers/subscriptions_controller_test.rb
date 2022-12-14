require "test_helper"

class SubscriptionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get subscriptions_new_url
    assert_response :success
  end

  test "should get index" do
    get subscriptions_index_url
    assert_response :success
  end

  test "should get show" do
    get subscriptions_show_url
    assert_response :success
  end

  test "should get edit" do
    get subscriptions_edit_url
    assert_response :success
  end

  test "should get confirm" do
    get subscriptions_confirm_url
    assert_response :success
  end
end
