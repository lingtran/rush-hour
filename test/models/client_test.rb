require_relative '../test_helper'

module RushHour
  class ClientTest < Minitest::Test
    include TestHelpers

    def test_client_class_can_be_created
      # add route to test: post '/sources', parameters
      assert Client.create({ :identifier => "jumpstartlab", :rootUrl => "http://jumpstartlab.com" })
      refute Client.new.valid?
    end

    def test_client_has_payload_requests
      # add route to test: post '/sources/:identifier/data', parameters
      client = create_client("jumpstartlab", "jumpstartlab.com")
      assert_respond_to client, :payload_requests
    end

    def test_cannot_send_duplicate_client
      # add route to test: post '/sources/:identifier/data', parameters

      create_client("jumpstartlab", "jumpstartlab.com")
      # refute create_client("jumpstartlab", "jumpstartlab.com")
    end
  end
end
