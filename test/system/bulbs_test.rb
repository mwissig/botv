require "application_system_test_case"

class BulbsTest < ApplicationSystemTestCase
  setup do
    @bulb = bulbs(:one)
  end

  test "visiting the index" do
    visit bulbs_url
    assert_selector "h1", text: "Bulbs"
  end

  test "creating a Bulb" do
    visit bulbs_url
    click_on "New Bulb"

    fill_in "Color", with: @bulb.color
    fill_in "Parent", with: @bulb.parent_id
    fill_in "Parent type", with: @bulb.parent_type
    fill_in "User", with: @bulb.user_id
    click_on "Create Bulb"

    assert_text "Bulb was successfully created"
    click_on "Back"
  end

  test "updating a Bulb" do
    visit bulbs_url
    click_on "Edit", match: :first

    fill_in "Color", with: @bulb.color
    fill_in "Parent", with: @bulb.parent_id
    fill_in "Parent type", with: @bulb.parent_type
    fill_in "User", with: @bulb.user_id
    click_on "Update Bulb"

    assert_text "Bulb was successfully updated"
    click_on "Back"
  end

  test "destroying a Bulb" do
    visit bulbs_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Bulb was successfully destroyed"
  end
end
