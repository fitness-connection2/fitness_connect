require "test_helper"

class Public::TrainersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get public_trainers_show_url
    assert_response :success
  end

  test "should get edit" do
    get public_trainers_edit_url
    assert_response :success
  end

  test "should get confirm" do
    get public_trainers_confirm_url
    assert_response :success
  end
end
