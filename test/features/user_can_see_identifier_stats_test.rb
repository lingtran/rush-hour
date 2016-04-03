require_relative '../test_helper.rb'

module RushHour
  class UserCanSeeIdentifierStatsTest < Minitest::Test
    include TestHelpers
    include Capybara::DSL

    def test_user_can_see_statistics_on_identifier_page
      #  issues with these identifiers (nil class): turing, microsoft, yahoo, apple, palantir, facebook
      create_data

      visit '/sources/jumpstartlab' #calling this path correctly?
      assert_equal '/sources/jumpstartlab', current_path
      assert page.has_content?("Average Response Time Across All Requests:")
      assert page.has_content?(63.0)
      assert page.has_content?("Max Response Time Across All Requests:")
      assert page.has_content?(65)
      assert page.has_content?("Minimum Response Time Across All Requests:")
      assert page.has_content?(61)
      assert page.has_content?("Most Frequent Request Type:")
      assert page.has_content?("GET")
      assert page.has_content?("List of All HTTP Verbs Used:")
      assert page.has_content?("GET")
      assert page.has_content?("POST")
      assert page.has_content?("List of URLs - Most to Least Requested:")
      assert page.has_content?(["jumpstartlab.com/home", "jumpstartlab.com/blog"])
      assert page.has_content?("Web Browser Breakdown Across All Requests:")
      assert page.has_content?(["Safari", "Mozilla"])
      assert page.has_content?("OS Breakdown Across All Requests:")
      assert page.has_content?(["Macintosh", "Windows"])
      assert page.has_content?("Screen Resolutions Across All Requests (resolutionWidth x resolutionHeight):")
      assert page.has_content?(["1920 x 1280", "800 x 640"])
    end

  end
end
