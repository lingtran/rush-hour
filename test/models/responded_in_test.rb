require_relative '../test_helper'

module RushHour
  class RespondedInTest < Minitest::Test
    include TestHelpers

    def test_responded_in_class_can_be_created
      assert RespondedIn.create({:responded_in => "responded_in"})
      refute RespondedIn.new.valid?
    end

    def test_responded_in_has_payload_requests
      responded_in = create_responded_in(15)
      assert_respond_to responded_in, :payload_requests
    end
  end
end
