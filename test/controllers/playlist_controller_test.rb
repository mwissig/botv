require 'test_helper'

class PlaylistControllerTest < ActionDispatch::IntegrationTest
  test "should get createplaylist" do
    get playlist_createplaylist_url
    assert_response :success
  end

end
