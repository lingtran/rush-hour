require_relative '../test_helper'

class ClientTest < Minitest::Test
  include TestHelpers

  def test_client_class_can_be_created
    assert Client.create({ :identifier => "jumpstartlab", :rootUrl => "http://jumpstartlab.com" })
    refute Client.new.valid?
  end

  def test_client_has_payload_requests
    client = create_client("800", "600")
    assert_respond_to client, :payload_requests
  end

end
