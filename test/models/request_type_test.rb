require_relative '../test_helper'

module RushHour
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

    def test_most_frequent_request_type
      create_test_payload_requests(2)
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

      assert_equal "GET", RequestType.most_frequent_request_type
    end

  end

  def test_list_of_all_HTTP_verbs_used
    create_test_payload_requests(2)
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

    assert_equal ["GET", "POST"], RequestType.all_http_verbs
  end

end
