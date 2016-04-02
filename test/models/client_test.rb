require_relative '../test_helper'

module RushHour
  class ClientTest < Minitest::Test
    include TestHelpers

    def test_client_class_can_be_created
      assert Client.create({ :identifier => "jumpstartlab", :rootUrl => "http://jumpstartlab.com" })
      refute Client.new.valid?
    end

    def test_client_has_payload_requests
      client = create_data
      assert_respond_to client, :payload_requests
    end

    def test_cannot_send_duplicate_client
      client_two = create_client(identifier, "jumpstartlab1")
      assert client_one.valid?
      refute client_two.valid?
    end

    def test_can_get_average_response_time_for_all_requests
      skip
      create_data
    end

    def test_can_get_max_response_time_across_all_requests
      # Max Response time across all requests
      skip
    end

    def test_can_get_min_response_time_across_all_requests
      # Min Response time across all requests
      skip

    end

    def test_can_get_most_frequent_request_type
      # Most frequent request type
      skip

    end

    def test_can_get_list_of_all_HTTP_verbs_used
      # List of all HTTP verbs used
      skip

    end

    def test_can_get_list_of_urls_listed_from_most_requested_to_least_requested
      # List of URLs listed form most requested to least requested
      skip

    end

    def test_can_get_web_browser_breakdown_across_all_requests
      # Web browser breakdown across all requests
      skip

    end

    def test_can_get_os_breakdown_across_all_requests
      # OS breakdown across all requests
      skip

    end

    def test_can_get_screen_resolutions_acrosss_all_requests
      # Screen Resolutions across all requests (resolutionWidth x resolutionHeight)
      skip

    end


  end
end
