require "test_helper"

class Admin::TrainersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_trainers_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_trainers_show_url
    assert_response :success
  end

  test "should get edit" do
    get admin_trainers_edit_url
    assert_response :success
  end
end
