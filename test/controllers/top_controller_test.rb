require 'test_helper'

class TopControllerTest < ActionDispatch::IntegrationTest
  test "should get viewed" do
    get top_viewed_url
    assert_response :success
  end

  test "should get loved" do
    get top_loved_url
    assert_response :success
  end

  test "should get hated" do
    get top_hated_url
    assert_response :success
  end

  test "should get controversial" do
    get top_controversial_url
    assert_response :success
  end

end
