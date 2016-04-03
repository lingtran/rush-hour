require_relative '../test_helper'

module RushHour
  class ClientTest < Minitest::Test
    include TestHelpers
    include AttributeCreator

    def test_client_class_can_be_created

      assert Client.create({ :identifier => "jumpstartlab", :rootUrl => "http://jumpstartlab.com" })
      refute Client.new.valid?
    end

    def test_client_has_payload_requests
      create_data
      assert_respond_to @client1, :payload_requests
      assert_respond_to @client2, :payload_requests
    end

    def test_cannot_send_duplicate_client
      client_one = Client.create(:identifier => "jumpstartlab", :rootUrl => "jumpstartlab.com")

      client_two = Client.create(:identifier => "jumpstartlab", :rootUrl => "jumpstartlab.com")
      assert client_one.valid?
      refute client_two.valid?
    end


    def test_can_get_average_response_time_for_all_requests
      create_data
      client_one_avg_response_t = @client1.payload_requests.average_response_time
      client_two_avg_response_t = @client2.payload_requests.average_response_time
      assert_equal 61.5, client_one_avg_response_t.to_f.round(2)
      assert_equal 63.0, client_two_avg_response_t.to_f.round(2)
    end

    def test_can_get_max_response_time_across_all_requests
      create_data
      client_one_max_response_t = @client1.payload_requests.max_response_time
      client_two_max_response_t = @client2.payload_requests.max_response_time
      assert_equal 62, client_one_max_response_t
      assert_equal 65, client_two_max_response_t
    end

    def test_can_get_min_response_time_across_all_requests
      create_data
      client_one_min_response_t = @client1.payload_requests.min_response_time
      client_two_min_response_t = @client2.payload_requests.min_response_time
      assert_equal 60, client_one_min_response_t
      assert_equal 61, client_two_min_response_t
    end

    def test_can_get_most_frequent_request_type
      create_data
      client_one_freq_request_type = @client1.request_types.most_frequent_request_type
      client_two_freq_request_type = @client2.request_types.most_frequent_request_type
      assert_equal "POST", client_one_freq_request_type
      assert_equal "GET", client_two_freq_request_type
    end

    def test_can_get_list_of_all_HTTP_verbs_used
      create_data
      client_one_all_http_verbs = @client1.request_types.all_http_verbs
      client_two_all_http_verbs = @client2.request_types.all_http_verbs
      assert client_one_all_http_verbs.include?("POST")
      assert client_two_all_http_verbs.include?("GET")
    end

    def test_can_get_list_of_urls_listed_from_most_requested_to_least_requested
      create_data
      client_one_list_of_urls = @client1.payload_requests.list_of_urls_ranked
      client_two_list_of_urls = @client2.payload_requests.list_of_urls_ranked

      client_one_result = ["jumpstartlab.com/exam", "jumpstartlab.com/blog"]
      client_two_result = ["jumpstartlab.com/home", "jumpstartlab.com/blog"]
      assert_equal client_one_result, client_one_list_of_urls
      assert_equal client_two_result, client_two_list_of_urls
    end

    def test_can_get_web_browser_breakdown_across_all_requests
      create_data
      client_one_web_browser_breakdown = @client1.payload_requests.web_browser_breakdown
      client_two_web_browser_breakdown = @client2.payload_requests.web_browser_breakdown
      assert_equal ["Chrome", "Safari", "Mozilla"], client_one_web_browser_breakdown
      assert_equal ["Safari", "Mozilla"], client_two_web_browser_breakdown
    end

    def test_can_get_os_breakdown_across_all_requests
      create_data
      client_one_os_breakdown = @client1.payload_requests.os_breakdown
      client_two_os_breakdown = @client2.payload_requests.os_breakdown
      assert_equal ["Macintosh", "Windows"], client_one_os_breakdown
      assert_equal ["Macintosh", "Windows"], client_two_os_breakdown

    end

    def test_can_get_screen_resolutions_acrosss_all_requests
      create_data
      client_one_res_breakdown = @client1.payload_requests.resolution_breakdown
      client_two_res_breakdown = @client2.payload_requests.resolution_breakdown
      assert client_one_res_breakdown.include?("1920 x 1280")
      assert client_two_res_breakdown.include?("800 x 640")
    end

  end
end
