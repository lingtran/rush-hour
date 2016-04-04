require_relative '../test_helper.rb'

module RushHour
  class UserCanSeeEventStatsTest < Minitest::Test
    include TestHelpers
    include Capybara::DSL

    def test_user_can_see_event_stats
      create_data
      visit '/sources/jumpstartlab/events/event1'
      assert_equal '/sources/jumpstartlab/events/event1', current_path
      assert page.has_content?("Requests by hour")
      assert page.has_content?("Client Hourly Payload Statistics")
      assert page.has_content?("Total number of times event was received:")
      assert page.has_content?("4")

    end

  end
end
