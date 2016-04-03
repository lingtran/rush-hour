require_relative '../test_helper'

module RushHour
  class UrlTest < Minitest::Test
    include TestHelpers
    include AttributeCreator

    def test_url_class_can_be_created
      assert Url.create({:root => "google.com", :path => "search"})
      refute Url.new.valid?
    end

    def test_url_has_payload_requests
      url = create_url("google.com", "search")
      assert_respond_to url, :payload_requests
    end

    def test_url_has_request_types
      url = create_url("google.com", "search")
      assert_respond_to url, :request_types
    end

    def test_url_has_referred_bies
      url = create_url("google.com", "search")
      assert_respond_to url, :referred_bies
    end

    def test_url_has_user_agents
      url = create_url("google.com", "search")
      assert_respond_to url, :user_agents
    end

    def test_max_response_time
      create_data
      assert_equal 62, Url.find(2).payload_requests.max_response_time
      assert_equal 65, Url.find(3).payload_requests.max_response_time
    end


    def test_min_response_time_by_url
      create_data

      assert_equal 61, Url.last.payload_requests.min_response_time
      assert_equal 60, Url.first.payload_requests.min_response_time

    end
    #
    def test_average_response_time_by_url
      create_data

      assert_equal 62.33, Url.last.payload_requests.average_response_time
    end

    def test_all_response_times_for_url_are_ordered
      create_data
      assert_equal [65, 61, 61], Url.last.all_response_times_for_url_ordered
    end

    def test_all_http_verbs_by_url
      create_data

      assert Url.find(3).http_verbs_for_url.include?("POST")
      assert Url.find(3).http_verbs_for_url.include?("GET")
      assert_equal ["POST"], Url.find(2).http_verbs_for_url
    end

    def test_three_most_popular_referrers
      create_data

      result = ["jumpstartlab.com/path1: 1", "jumpstartlab.com/path2: 1"]
      assert_equal result, Url.first.three_most_popular_referrers
    end

    def test_three_most_popular_user_agents
      create_data

      result = ["Windows Mozilla: 1", "Macintosh Chrome: 1"]
      assert_equal result, Url.first.three_most_popular_user_agents
    end

  end
end
