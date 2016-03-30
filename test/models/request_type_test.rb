require_relative '../test_helper'

class RequestTypeTest < Minitest::Test
  include TestHelpers

  def test_request_type_class_can_be_created
    assert RequestType.create({:verb => "Get"})
    refute RequestType.new.valid?
  end

  def test_request_type_has_payload_requests
    request_type = create_request_type("Get")
    assert_respond_to request_type, :payload_requests
  end
end
