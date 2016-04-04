require_relative '../test_helper.rb'

module RushHour
  class UserCanSeeIdentifierStatsTest < Minitest::Test
    include TestHelpers
    include Capybara::DSL

    def test_user_can_see_statistics_on_identifier_page
      create_data

      visit '/sources/jumpstartlab'
      assert_equal '/sources/jumpstartlab', current_path
      assert page.has_content?("Average Response Time")
      assert page.has_content?(63.0)
      assert page.has_content?("Max Response Time")
      assert page.has_content?(65)
      assert page.has_content?("Min Response Time")
      assert page.has_content?(61)
      assert page.has_content?("Most Frequent Request Type")
      assert page.has_content?("GET")
      assert page.has_content?("All Verbs Used")
      assert page.has_content?("URLs Ordered By Requests")
      assert page.has_content?("Web Browsers Used")
      assert page.has_content?("Safari, Mozilla")
      assert page.has_content?("Operating Systems Used")
      assert page.has_content?("Macintosh, Windows")
      assert page.has_content?("Resolutions Used")
      assert page.has_content?("1920 x 1280")
    end

  end
end
