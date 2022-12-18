require "test_helper"

class Admin::PaymentsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_payments_index_url
    assert_response :success
  end

  test "should get edit" do
    get admin_payments_edit_url
    assert_response :success
  end
end
