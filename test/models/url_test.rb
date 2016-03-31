require_relative '../test_helper'

class UrlTest < Minitest::Test
  include TestHelpers

  def test_url_class_can_be_created
    assert Url.create({:root => "google.com", :path => "search"})
    refute Url.new.valid?
  end

  def test_url_has_payload_requests
    url = create_url("google.com", "search")
    assert_respond_to url, :payload_requests
  end

  def test_max_response_time
    create_payload_requests(1)
    create_payload_requests(2)
    assert_equal 2, Url.last.max_response_time_by_url
    assert_equal 1, Url.first.max_response_time_by_url
  end

  # def test_max_response_time_by_url
  #   create_payload_requests(1)
  #   create_payload_requests(2)
  #   assert_equal 2, Url.max_response_time_by_url("google.com/search2")
  #   assert_equal 1, Url.max_response_time_by_url("google.com/search1")
  # end

  def test_min_response_time_by_url
    create_payload_requests(3)
    create_payload_requests(3)
    PayloadRequest.create({
      :url_id       => create_url("google.com", "/search3").id,
      :requested_at => Date.new(2016, 01, 01),
      :responded_in_id => create_responded_in(3).id,
      :referred_by_id => create_referred_by("bing.com", "/search3").id,
      :request_type_id => create_request_type("GET").id,
      :event_name_id => create_event_name("eventName 3").id,
      :user_agent_id => create_user_agent("OSX3", "Chrome 3").id,
      :resolution_id => create_resolution("resolutionWidth 3", "resolutionHeight 3").id,
      :ip_id => create_ip("127.0.0.3").id
      })

    assert_equal 3, Url.last.min_response_time_by_url
    assert_equal 1, Url.first.min_response_time_by_url

  end

  def test_average_response_time_by_url
    create_payload_requests(3)
    create_payload_requests(3)
    create_payload_requests(3)
    assert_equal 1, Url.average_response_time_by_url("google.com/search1")
  end
end
