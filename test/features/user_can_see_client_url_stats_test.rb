require_relative '../test_helper.rb'

module RushHour
  class UserCanSeeClientSpecificUrlStatsTest < Minitest::Test
    include TestHelpers
    include Capybara::DSL


    def test_user_can_see_statistics_for_url_specific_to_client
      skip
      create_data
      visit '/sources/jumpstartlab'
      assert_equal '/sources/jumpstartlab', current_path
      assert page.has_content?("http://jumpstartlab.com/blog")


      click_link("http://jumpstartlab.com/blog")
      assert '/sources/jumpstartlab/urls/blog', current_path
      assert_equal '/sources/jumpstartlab/urls/blog', current_path
      assert page.has_content?("Max Response Time")
    end
  end
end


Max Response time
Min Response time
A list of response times across all requests listed from longest response time to shortest response time.
Average Response time for this URL
HTTP Verb(s) associated used to it this URL
Three most popular referrers
Three most popular user agents
