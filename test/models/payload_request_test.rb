require_relative '../test_helper'

module RushHour
  class PayloadRequestTest < Minitest::Test

    include TestHelpers
    include AttributeCreator

    def test_payload_request_class_can_be_created
      create_data
      refute PayloadRequest.all.empty?

      payload_request = PayloadRequest.last
      assert_equal 19, payload_request.requested_at.hour
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
      assert_equal "path2", payload_request.referred_by.path

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
      assert_equal 62.25, PayloadRequest.average_response_time
    end

    def test_max_response_time_across_all_requests
      create_data
      assert_equal 65, PayloadRequest.max_response_time
    end

    def test_min_response_time_across_all_requests
      create_data
      assert_equal 60, PayloadRequest.min_response_time
    end

    def test_list_of_urls
      create_data
      result = ["jumpstartlab.com/blog", "jumpstartlab.com/home", "jumpstartlab.com/exam"]
      assert_equal result, PayloadRequest.list_of_urls_unique
    end

    def test_list_of_urls_listed_form_most_requested_to_least_requested
      create_data
      assert PayloadRequest.list_of_urls_ranked.include?("jumpstartlab.com/exam")
      assert PayloadRequest.list_of_urls_ranked.include?("jumpstartlab.com/home")
      assert PayloadRequest.list_of_urls_ranked.include?("jumpstartlab.com/blog")
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
      result = ["1920 x 1280", "800 x 640"]
      assert_equal result, PayloadRequest.resolution_breakdown
    end

    def test_can_validate_uniqueness_of_payload_request
      create_data
      payload1 = {
          url_id: @url1.id,
          requested_at: "2015-04-01 12:20:40 -700",
          responded_in: 60,
          referred_by_id: @referral1.id,
          request_type_id: @request_type2.id,
          event_name_id: @event1.id,
          user_agent_id: @agent1.id,
          resolution_id: @resolution1.id,
          ip_id: @ip1.id,
          client_id: @client1.id
      }
      refute PayloadRequest.new(payload1).save
    end

    def test_can_get_events_by_hour
      create_data
      assert_equal [19, 19, 19, 19], EventName.first.payload_requests.map { |pr| pr.requested_at.hour }
    end

    def test_can_get_count_of_events_per_hour
      create_data
      assert_equal 4, EventName.first.payload_requests.count_requests
    end

  end
end
