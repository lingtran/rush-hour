require_relative '../test_helper.rb'

module RushHour
  class UserCanSeeClientSpecificUrlStatsTest < Minitest::Test
    include TestHelpers
    include Capybara::DSL

    def test_user_can_see_statistics_for_url_specific_to_client
      create_data
      visit '/sources/jumpstartlab'
      assert_equal '/sources/jumpstartlab', current_path
      assert page.has_content?("jumpstartlab")

      click_link("jumpstartlab.com/blog")
      assert '/sources/jumpstartlab/urls/blog', current_path
      assert_equal '/sources/jumpstartlab/urls/blog', current_path
      assert page.has_content?("Max Response Time")
      assert page.has_content?("65")
      assert page.has_content?("Min Response Time")
      assert page.has_content?("60")
      assert page.has_content?("All Response Times Ordered")
      assert page.has_content?("65, 60")
      assert page.has_content?("Average Response Time")
      assert page.has_content?("62.5")
      assert page.has_content?("HTTP Verbs for this URL")
      assert page.has_content?('POST, GET')
      assert page.has_content?("Three Most Popular Referrers")
      assert page.has_content?('jumpstartlab.com/path1: 1, jumpstartlab.com/path2: 1')
      assert page.has_content?("Three Most Popular User Agents")
      assert page.has_content?('Windows Mozilla: 1 Macintosh Chrome: 1')
    end
  end
end
