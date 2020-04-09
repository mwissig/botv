require "application_system_test_case"

class PermissionsTest < ApplicationSystemTestCase
  setup do
    @permission = permissions(:one)
  end

  test "visiting the index" do
    visit permissions_url
    assert_selector "h1", text: "Permissions"
  end

  test "creating a Permission" do
    visit permissions_url
    click_on "New Permission"

    fill_in "Bulb ban end", with: @permission.bulb_ban_end
    check "Can bulb" if @permission.can_bulb
    check "Can comment" if @permission.can_comment
    check "Can post video" if @permission.can_post_video
    fill_in "Comment ban end", with: @permission.comment_ban_end
    check "Is admin" if @permission.is_admin
    check "Is mod" if @permission.is_mod
    fill_in "User", with: @permission.user_id
    fill_in "Video ban end", with: @permission.video_ban_end
    click_on "Create Permission"

    assert_text "Permission was successfully created"
    click_on "Back"
  end

  test "updating a Permission" do
    visit permissions_url
    click_on "Edit", match: :first

    fill_in "Bulb ban end", with: @permission.bulb_ban_end
    check "Can bulb" if @permission.can_bulb
    check "Can comment" if @permission.can_comment
    check "Can post video" if @permission.can_post_video
    fill_in "Comment ban end", with: @permission.comment_ban_end
    check "Is admin" if @permission.is_admin
    check "Is mod" if @permission.is_mod
    fill_in "User", with: @permission.user_id
    fill_in "Video ban end", with: @permission.video_ban_end
    click_on "Update Permission"

    assert_text "Permission was successfully updated"
    click_on "Back"
  end

  test "destroying a Permission" do
    visit permissions_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Permission was successfully destroyed"
  end
end
