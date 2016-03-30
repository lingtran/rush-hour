require_relative '../test_helper'

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
end
