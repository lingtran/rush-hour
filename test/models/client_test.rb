require_relative '../test_helper'

module RushHour
  class ClientTest < Minitest::Test
    include TestHelpers

    def test_client_class_can_be_created
      assert Client.create({ :identifier => "jumpstartlab", :rootUrl => "http://jumpstartlab.com" })
      refute Client.new.valid?
    end

    def test_client_has_payload_requests
      client = create_client("jumpstartlab", "jumpstartlab.com")
      assert_respond_to client, :payload_requests
    end

    def test_cannot_send_duplicate_client
      create_client("jumpstartlab", "jumpstartlab.com")
      assert_equal 1,  create_client("jumpstartlab", "jumpstartlab.com").id
    end
  end
end
