require_relative '../test_helper.rb'

module RushHour
  class UserCanSeeEventsIndexTest < Minitest::Test
    include TestHelpers
    include Capybara::DSL

    def test_user_can_see_application_events_index_for_a_client_when_event_undefined
      create_data
      visit '/sources/jumpstartlab/events/startedRegistration'
      assert page.has_content?("Event Error")
      assert page.has_link?("Application Events Index")

      click_link("Application Events Index")

      assert_equal '/sources/jumpstartlab/events', current_path
      assert page.has_link?("event1")
      assert page.has_link?("event2")
      assert page.has_link?("event3")
    end
  end
end
