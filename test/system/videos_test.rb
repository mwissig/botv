require "application_system_test_case"

class VideosTest < ApplicationSystemTestCase
  setup do
    @video = videos(:one)
  end

  test "visiting the index" do
    visit videos_url
    assert_selector "h1", text: "Videos"
  end

  test "creating a Video" do
    visit videos_url
    click_on "New Video"

    fill_in "Category1", with: @video.category1
    fill_in "Category2", with: @video.category2
    fill_in "Description", with: @video.description
    fill_in "Downbulbs", with: @video.downbulbs
    fill_in "Duration", with: @video.duration
    fill_in "Embed code", with: @video.embed_code
    fill_in "Embed url", with: @video.embed_url
    fill_in "Id code", with: @video.id_code
    fill_in "Provider", with: @video.provider
    fill_in "Tags", with: @video.tags
    fill_in "Thumbnail", with: @video.thumbnail
    fill_in "Title", with: @video.title
    fill_in "Upbulbs", with: @video.upbulbs
    fill_in "User", with: @video.user_id
    click_on "Create Video"

    assert_text "Video was successfully created"
    click_on "Back"
  end

  test "updating a Video" do
    visit videos_url
    click_on "Edit", match: :first

    fill_in "Category1", with: @video.category1
    fill_in "Category2", with: @video.category2
    fill_in "Description", with: @video.description
    fill_in "Downbulbs", with: @video.downbulbs
    fill_in "Duration", with: @video.duration
    fill_in "Embed code", with: @video.embed_code
    fill_in "Embed url", with: @video.embed_url
    fill_in "Id code", with: @video.id_code
    fill_in "Provider", with: @video.provider
    fill_in "Tags", with: @video.tags
    fill_in "Thumbnail", with: @video.thumbnail
    fill_in "Title", with: @video.title
    fill_in "Upbulbs", with: @video.upbulbs
    fill_in "User", with: @video.user_id
    click_on "Update Video"

    assert_text "Video was successfully updated"
    click_on "Back"
  end

  test "destroying a Video" do
    visit videos_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Video was successfully destroyed"
  end
end
