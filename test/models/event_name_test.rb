require_relative '../test_helper'

module RushHour
  class EventNameTest < Minitest::Test
    include TestHelpers

    def test_event_name_class_can_be_created
      assert EventName.create({:event_name => "Login"})
      refute EventName.new.valid?
    end

    def test_event_name_has_payload_requests
      event_name = create_event_name("Login")
      assert_respond_to event_name, :payload_requests
    end

    def test_events_listed_from_most_received_to_least
      create_test_payload_requests(3)
      create_test_payload_requests(2)
      create_test_payload_requests
      assert_equal ({"eventName 1"=>3, "eventName 2"=>2, "eventName 3"=>1}), EventName.ordered_events
    end

    def test_cannot_duplicate_event_names
      create_event_name("event")
      assert_equal 1, create_event_name("event").id
    end
  end
end
