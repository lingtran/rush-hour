require_relative '../test_helper'

module RushHour
  class PayloadRequestTest < Minitest::Test

    include TestHelpers
    include PayloadCreator

    def test_payload_request_class_can_be_created
      create_data
      refute PayloadRequest.all.empty?

      payload_request = PayloadRequest.last
      assert_equal Date.new(2015, 04, 01), payload_request.requested_at
    end

    def test_payload_request_class_has_responded_in
      create_data
      payload_request = PayloadRequest.last
      assert_respond_to payload_request, :responded_in
      assert_equal 65, payload_request.responded_in
    end

    def test_payload_request_class_has_event_name
      create_data
      payload_request = PayloadRequest.last
      assert_respond_to payload_request, :event_name
      assert_equal "event2", payload_request.event_name.event_name
    end

    def test_payload_request_class_has_ip
      create_data
      payload_request = PayloadRequest.last
      assert_respond_to payload_request, :ip
      assert_equal "127.0.0.3", payload_request.ip.ip.to_s
    end


    def test_payload_request_class_has_referred_by
      create_data
      payload_request = PayloadRequest.last
      assert_respond_to payload_request, :referred_by
      assert_equal "jumpstartlab.com", payload_request.referred_by.root
      assert_equal "path3", payload_request.referred_by.path

    end

    def test_payload_request_class_has_request_type
      create_data
      payload_request = PayloadRequest.last
      assert_respond_to payload_request, :request_type
      assert_equal "GET", payload_request.request_type.verb
    end

    def test_payload_request_class_has_resolution
      create_data
      payload_request = PayloadRequest.last
      assert_respond_to payload_request, :resolution
      assert_equal "1920", payload_request.resolution.width
    end

    def test_payload_request_class_has_url
      create_data
      payload_request = PayloadRequest.last
      assert_respond_to payload_request, :url
      assert_equal "jumpstartlab.com", payload_request.url.root
      assert_equal "home", payload_request.url.path

    end

    def test_payload_request_class_has_user_agent
      create_data
      payload_request = PayloadRequest.last
      assert_respond_to payload_request, :user_agent
      assert_equal "Windows", payload_request.user_agent.os
      assert_equal "Mozilla", payload_request.user_agent.browser
    end

    def test_payload_request_class_has_client
      create_data
      payload_request = PayloadRequest.last
      assert_respond_to payload_request, :client
      assert_equal "jumpstartlab", payload_request.client.identifier
      assert_equal "http://jumpstartlab.com", payload_request.client.rootUrl
    end

    def test_average_response_time_for_our_clients_app_across_all_requests
      create_data
      assert_equal 1.5, PayloadRequest.average_response_time
    end

    def test_max_response_time_across_all_requests
      create_data
      assert_equal 2, PayloadRequest.max_response_time
    end

    def test_min_response_time_across_all_requests
      create_data
      assert_equal 1, PayloadRequest.min_response_time
    end

    def test_list_of_urls
      create_data
      result = ["jumpstartlab.com/blog", "jumpstartlab.com/home", "jumpstartlab.com/exam"]
      assert_equal result, PayloadRequest.list_of_urls_unique
    end

    def test_list_of_urls_listed_form_most_requested_to_least_requested
      create_data
      result = ["jumpstartlab.com/home", "jumpstartlab.com/exam", "jumpstartlab.com/blog"]
      assert_equal result, PayloadRequest.list_of_urls_ranked
    end

    def test_web_browser_breakdown_across_all_requests
      create_data
      assert_equal ["Chrome", "Safari", "Mozilla"], PayloadRequest.web_browser_breakdown
    end

    def test_osx_breakdown_across_all_requests
      create_data
      assert_equal ["Macintosh", "Windows"], PayloadRequest.os_breakdown
    end

    def test_screen_resolutions_across_all_requests
      create_data
      result = ["resolutionWidth 1 x resolutionHeight 1", "resolutionWidth 2 x resolutionHeight 2"]
      assert_equal result, PayloadRequest.resolution_breakdown
    end

    def test_can_validate_uniqueness_of_payload_request
      create_data
      payload_one = PayloadRequest.first
      payload_two = PayloadRequest.last
      payload_one.valid?
      payload_two.valid?
      assert_nil payload_two.errors.on(:client_id)
    end

  end
end
