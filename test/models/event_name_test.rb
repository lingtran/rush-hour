require_relative '../test_helper'

module RushHour
  class EventNameTest < Minitest::Test
    include TestHelpers
    include AttributeCreator

    def test_event_name_class_can_be_created_and_not_duplicated
      assert EventName.create({:event_name => "Login"})
      refute EventName.new.valid?
      refute EventName.new({:event_name => "Login"}).save
    end

    def test_event_name_has_payload_requests
      event_name = create_event_name("Login")
      assert_respond_to event_name, :payload_requests
    end

    def test_events_listed_from_most_received_to_least
      create_data
      assert_equal ({"event1"=>4, "event2"=>3, "event3"=>1}), EventName.ordered_events
    end
  end
end
