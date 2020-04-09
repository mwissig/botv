require 'test_helper'

class BansControllerTest < ActionDispatch::IntegrationTest
  test "should get mod" do
    get bans_mod_url
    assert_response :success
  end

  test "should get index" do
    get bans_index_url
    assert_response :success
  end

end
