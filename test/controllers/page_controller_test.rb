require 'test_helper'

class PageControllerTest < ActionDispatch::IntegrationTest
  test "should get sources" do
    get page_sources_url
    assert_response :success
  end

end
