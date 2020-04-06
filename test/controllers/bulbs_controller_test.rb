require 'test_helper'

class BulbsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bulb = bulbs(:one)
  end

  test "should get index" do
    get bulbs_url
    assert_response :success
  end

  test "should get new" do
    get new_bulb_url
    assert_response :success
  end

  test "should create bulb" do
    assert_difference('Bulb.count') do
      post bulbs_url, params: { bulb: { color: @bulb.color, parent_id: @bulb.parent_id, parent_type: @bulb.parent_type, user_id: @bulb.user_id } }
    end

    assert_redirected_to bulb_url(Bulb.last)
  end

  test "should show bulb" do
    get bulb_url(@bulb)
    assert_response :success
  end

  test "should get edit" do
    get edit_bulb_url(@bulb)
    assert_response :success
  end

  test "should update bulb" do
    patch bulb_url(@bulb), params: { bulb: { color: @bulb.color, parent_id: @bulb.parent_id, parent_type: @bulb.parent_type, user_id: @bulb.user_id } }
    assert_redirected_to bulb_url(@bulb)
  end

  test "should destroy bulb" do
    assert_difference('Bulb.count', -1) do
      delete bulb_url(@bulb)
    end

    assert_redirected_to bulbs_url
  end
end
