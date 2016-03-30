require_relative '../test_helper'
require 'pry'
require 'ipaddr'

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

  def test_payload_request_class_has_event_name
    create_payload_requests
    payload_request = PayloadRequest.last
    assert_respond_to payload_request, :event_name
    assert_equal "eventName 1", payload_request.event_name.event_name
  end

  def test_payload_request_class_has_ip
    create_payload_requests
    payload_request = PayloadRequest.last
    assert_respond_to payload_request, :ip
    p IPAddr.new "127.0.0.1/32"
    assert_equal "127.0.0.1", payload_request.ip.ip.to_s
  end


  def test_payload_request_class_has_referred_by
    create_payload_requests
    payload_request = PayloadRequest.last
    assert_respond_to payload_request, :referred_by
    assert_equal "bing.com", payload_request.referred_by.root
    assert_equal "/search1", payload_request.referred_by.path

  end

  def test_payload_request_class_has_request_type
    create_payload_requests
    payload_request = PayloadRequest.last
    assert_respond_to payload_request, :request_type
    assert_equal "GET", payload_request.request_type.verb
  end

  def test_payload_request_class_has_resolution
    create_payload_requests
    payload_request = PayloadRequest.last
    assert_respond_to payload_request, :resolution
    assert_equal "resolutionWidth 1", payload_request.resolution.width
  end

  def test_payload_request_class_has_url
    create_payload_requests
    payload_request = PayloadRequest.last
    assert_respond_to payload_request, :url
    assert_equal "google.com", payload_request.url.root
    assert_equal "/search1", payload_request.url.path

  end

  def test_payload_request_class_has_user_agent
    create_payload_requests
    payload_request = PayloadRequest.last
    assert_respond_to payload_request, :user_agent
    assert_equal "OSX", payload_request.user_agent.os
    assert_equal "Chrome 1", payload_request.user_agent.browser

  end
end
