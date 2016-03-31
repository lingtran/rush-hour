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
    assert_equal "OSX1", payload_request.user_agent.os
    assert_equal "Chrome 1", payload_request.user_agent.browser
  end

  def test_payload_request_class_has_client
    create_payload_requests
    payload_request = PayloadRequest.last
    assert_respond_to payload_request, :client
    assert_equal "jumpstartlab", payload_request.client.identifier
    assert_equal "http://jumpstartlab.com", payload_request.client.rootUrl
  end

  def test_average_response_time_for_our_clients_app_across_all_requests
    create_payload_requests(2)
    assert_equal 1.5, PayloadRequest.average_response_time
  end

  def test_max_response_time_across_all_requests
    create_payload_requests(2)
    assert_equal 2, PayloadRequest.max_response_time
  end

  def test_min_response_time_across_all_requests
    create_payload_requests(2)
    assert_equal 1, PayloadRequest.min_response_time
  end

  def test_most_frequent_request_type
    create_payload_requests(2)
    PayloadRequest.create({
      :url_id       => create_url("google.com", "/search").id,
      :requested_at => Date.new(2016, 01, 01),
      :responded_in_id => create_responded_in(1).id,
      :referred_by_id => create_referred_by("bing.com", "/search1").id,
      :request_type_id => create_request_type("POST").id,
      :event_name_id => create_event_name("eventName").id,
      :user_agent_id => create_user_agent("OSX1", "Chrome ").id,
      :resolution_id => create_resolution("resolutionWidth ", "resolutionHeight ").id,
      :ip_id => create_ip("127.0.0.27").id,
      :client_id => create_client("jumpstartlab", "http://jumpstartlab.com").id
      })

    assert "GET", PayloadRequest.most_frequent_request_type
  end

  def test_list_of_all_HTTP_verbs_used
    create_payload_requests(2)
    PayloadRequest.create({
      :url_id       => create_url("google.com", "/search").id,
      :requested_at => Date.new(2016, 01, 01),
      :responded_in_id => create_responded_in(1).id,
      :referred_by_id => create_referred_by("bing.com", "/search1").id,
      :request_type_id => create_request_type("POST").id,
      :event_name_id => create_event_name("eventName").id,
      :user_agent_id => create_user_agent("OSX1", "Chrome ").id,
      :resolution_id => create_resolution("resolutionWidth ", "resolutionHeight ").id,
      :ip_id => create_ip("127.0.0.32").id,
      :client_id => create_client("jumpstartlab", "http://jumpstartlab.com").id
      })

    assert ["GET", "POST"], PayloadRequest.all_http_verbs
  end

  def test_list_of_urls_listed_form_most_requested_to_least_requested
    create_payload_requests(3)
    create_payload_requests(2)
    create_payload_requests

    result = ["google.com/search1", "google.com/search2", "google.com/search3"]
    assert_equal result, PayloadRequest.list_of_urls
  end

  def test_web_browser_breakdown_across_all_requests
    create_payload_requests(2)
    assert_equal ["Chrome 1", "Chrome 2"], PayloadRequest.web_browser_breakdown
  end

  def test_osx_breakdown_across_all_requests
    create_payload_requests(2)
    assert_equal ["OSX1", "OSX2"], PayloadRequest.os_breakdown
  end

  def test_screen_resolutions_across_all_requests
    create_payload_requests(2)
    result = ["resolutionWidth 1 x resolutionHeight 1", "resolutionWidth 2 x resolutionHeight 2"]
    assert_equal result, PayloadRequest.resolution_breakdown
  end

  def test_events_listed_from_most_received_to_least
    create_payload_requests(3)
    create_payload_requests(2)
    create_payload_requests

    assert_equal ["eventName 1", "eventName 2"], PayloadRequest.ordered_events
  end


end
