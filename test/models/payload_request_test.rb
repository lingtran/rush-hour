require_relative '../test_helper'

module RushHour
  class PayloadRequestTest < Minitest::Test

    include TestHelpers

    def test_payload_request_class_can_be_created
      assert PayloadRequest.new
      create_test_payload_requests
      refute PayloadRequest.all.empty?

      payload_request = PayloadRequest.last
      assert_equal Date.new(2016,01,01), payload_request.requested_at
    end

    def test_payload_request_class_has_responded_in
      create_test_payload_requests
      payload_request = PayloadRequest.last
      assert_respond_to payload_request, :responded_in
      assert_equal 1, payload_request.responded_in.responded_in
    end

    def test_payload_request_class_has_event_name
      create_test_payload_requests
      payload_request = PayloadRequest.last
      assert_respond_to payload_request, :event_name
      assert_equal "eventName 1", payload_request.event_name.event_name
    end

    def test_payload_request_class_has_ip
      create_test_payload_requests
      payload_request = PayloadRequest.last
      assert_respond_to payload_request, :ip
      assert_equal "127.0.0.1", payload_request.ip.ip.to_s
    end


    def test_payload_request_class_has_referred_by
      create_test_payload_requests
      payload_request = PayloadRequest.last
      assert_respond_to payload_request, :referred_by
      assert_equal "bing.com", payload_request.referred_by.root
      assert_equal "/search1", payload_request.referred_by.path

    end

    def test_payload_request_class_has_request_type
      create_test_payload_requests
      payload_request = PayloadRequest.last
      assert_respond_to payload_request, :request_type
      assert_equal "GET", payload_request.request_type.verb
    end

    def test_payload_request_class_has_resolution
      create_test_payload_requests
      payload_request = PayloadRequest.last
      assert_respond_to payload_request, :resolution
      assert_equal "resolutionWidth 1", payload_request.resolution.width
    end

    def test_payload_request_class_has_url
      create_test_payload_requests
      payload_request = PayloadRequest.last
      assert_respond_to payload_request, :url
      assert_equal "google.com", payload_request.url.root
      assert_equal "/search1", payload_request.url.path

    end

    def test_payload_request_class_has_user_agent
      create_test_payload_requests
      payload_request = PayloadRequest.last
      assert_respond_to payload_request, :user_agent
      assert_equal "OSX1", payload_request.user_agent.os
      assert_equal "Chrome 1", payload_request.user_agent.browser
    end

    def test_payload_request_class_has_client
      create_test_payload_requests
      payload_request = PayloadRequest.last
      assert_respond_to payload_request, :client
      assert_equal "jumpstartlab", payload_request.client.identifier
      assert_equal "http://jumpstartlab.com", payload_request.client.rootUrl
    end

    def test_average_response_time_for_our_clients_app_across_all_requests
      create_test_payload_requests(2)
      assert_equal 1.5, PayloadRequest.average_response_time
    end

    def test_max_response_time_across_all_requests
      create_test_payload_requests(2)
      assert_equal 2, PayloadRequest.max_response_time
    end

    def test_min_response_time_across_all_requests
      create_test_payload_requests(2)
      assert_equal 1, PayloadRequest.min_response_time
    end



    def test_web_browser_breakdown_across_all_requests
      create_test_payload_requests(2)
      assert_equal ["Chrome 1", "Chrome 2"], PayloadRequest.web_browser_breakdown
    end

    def test_osx_breakdown_across_all_requests
      create_test_payload_requests(2)
      assert_equal ["OSX1", "OSX2"], PayloadRequest.os_breakdown
    end

    def test_screen_resolutions_across_all_requests
      create_test_payload_requests(2)
      result = ["resolutionWidth 1 x resolutionHeight 1", "resolutionWidth 2 x resolutionHeight 2"]
      assert_equal result, PayloadRequest.resolution_breakdown
    end



  end
end
