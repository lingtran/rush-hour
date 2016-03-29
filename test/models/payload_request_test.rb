require_relative '../test_helper'
require 'pry'

class PayloadRequestTest < Minitest::Test

  include TestHelpers

  def test_payload_request_class_can_be_created

    assert PayloadRequest.new
    new_payload_request = create_payload_requests
    binding.pry
    refute new_payload_request.all.empty?
    expected = PayloadRequest.all.last.id
    assert_equal expected, PayloadRequest.find(new_payload_request.id).id
  end

end
