require_relative '../test_helper'

module RushHour
  class UrlTest < Minitest::Test
    include TestHelpers
    include PayloadCreator

    def test_url_class_can_be_created
      assert Url.create({:root => "google.com", :path => "search"})
      refute Url.new.valid?
    end

    def test_url_has_payload_requests
      url = create_url("google.com", "search")
      assert_respond_to url, :payload_requests
    end

    def test_url_has_responded_ins
      url = create_url("google.com", "search")
      assert_respond_to url, :responded_ins
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
      assert_equal 2, Url.last.max_response_time_by_url
      assert_equal 1, Url.first.max_response_time_by_url
    end


    def test_min_response_time_by_url
      create_data

      assert_equal 3, Url.last.min_response_time_by_url
      assert_equal 1, Url.first.min_response_time_by_url

    end
    #
    def test_average_response_time_by_url
      create_data

      assert_equal 2.0, Url.last.average_response_time_by_url
    end

    def test_all_response_times_for_url_are_ordered
      create_data

      assert_equal [3,1], Url.last.all_response_times_for_url_ordered
    end

    def test_all_http_verbs_by_url
      create_data
      assert_equal ["GET", "POST"], Url.find(3).http_verbs_for_url
      assert_equal ["POST"], Url.find(2).http_verbs_for_url
    end

    def test_three_most_popular_referrers
      create_data

      result = ["bing.com/search1: 4", "bing.com/search2: 3", "bing.com/search3: 2"]
      assert_equal result, Url.first.three_most_popular_referrers
    end

    def test_three_most_popular_user_agents
      create_data

      result = ["OSX1 Chrome 1: 4", "OSX2 Chrome 2: 3", "OSX3 Chrome 3: 2"]
      assert_equal result, Url.first.three_most_popular_user_agents
    end

    def test_list_of_urls_listed_form_most_requested_to_least_requested
      create_data
      result = ["google.com/search1", "google.com/search2", "google.com/search3"]
      assert_equal result, PayloadRequest.list_of_urls
    end

  end
end
