require_relative '../test_helper'

class EventNameTest < Minitest::Test
  include TestHelpers

  def test_event_name_class_can_be_created
    assert EventName.create({:event_name => "Login"})
  end
end
