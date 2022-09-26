require "test_helper"

class Public::Members::PostsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get public_members_posts_new_url
    assert_response :success
  end

  test "should get index" do
    get public_members_posts_index_url
    assert_response :success
  end

  test "should get show" do
    get public_members_posts_show_url
    assert_response :success
  end

  test "should get edit" do
    get public_members_posts_edit_url
    assert_response :success
  end
end
