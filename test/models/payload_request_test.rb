require_relative '../test_helper'

class PayloadRequestTest < Minitest::Test

  include TestHelpers

  def test_payload_request_class_can_be_created

    assert payload_requests = PayloadRequest.new
    new_payload_request = create_payload_requests
    expected = PayloadRequest.all.last.id
    assert_equal expected, PayloadRequest.find(new_payload_request.id).id
  end

end