require_relative '../test_helper'
require 'pry'

class PayloadRequestTest < Minitest::Test

  include TestHelpers

  def test_payload_request_class_can_be_created

    assert PayloadRequest.new
    create_payload_requests
    refute PayloadRequest.all.empty?

    payload_request = PayloadRequest.last
    assert_equal Date.new(2016,01,01), payload_request.requested_at
  end

  def test_payload_request_class_has_responded_in
    create_payload_requests
    payload_request = PayloadRequest.last
    assert_respond_to payload_request, :responded_in
    assert_equal 1, payload_request.responded_in.responded_in
  end
end
