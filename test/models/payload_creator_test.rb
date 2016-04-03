require_relative '../test_helper'
require 'pry'
module RushHour
  class PayloadCreatorTest < Minitest::Test
    include Rack::Test::Methods
    include TestHelpers
    include AttributeCreator

    def app
      RushHour::Server
    end

#     def params
#       {"payload"=>
#  "{\"url\":\"http://jumpstartlab.com/blog\",\"requestedAt\":\"2013-02-16 21:38:28 -0700\",\"respondedIn\":37,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"GET\",\"parameters\":[],\"eventName\":\"socialLogin\",\"userAgent\":\"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.38.211\"}",
# "splat"=>[],
# "captures"=>["jumpstartlab1"],
# "identifier"=>"jumpstartlab1",
# "rootUrl"=>"http://jumpstartlab.com"}
#     end
    #
    # def test_can_parse_params
    #
    #   result = {:url=>"http://jumpstartlab.com/blog",
    #   :requestedAt=>"2013-02-16 21:38:28 -0700",
    #   :respondedIn=>37,
    #   :referredBy=>"http://jumpstartlab.com/blog",
    #   :requestType=>"GET",
    #   :parameters=>[],
    #   :eventName=>"socialLogin",
    #   :userAgent=>"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
    #   :resolutionWidth=>"1920",
    #   :resolutionHeight=>"1280",
    #   :ip=>"63.29.38.211"}
    #   assert_equal result, params_parser(params)
    # end

    def test_can_parse_url
      pc = PayloadCreator.new(params)
      raw_params = JSON.parse(params["payload"])
      new_url = pc.parse_url(raw_params["url"])
      assert_equal "jumpstartlab.com", new_url[:root]
      assert_equal "blog", new_url[:path]
    end

    def test_user_agent_can_be_parsed_with_user_agent_gem
      pc = PayloadCreator.new(params)
      raw_params = JSON.parse(params["payload"])

      user_agent = pc.parse_user_agent(raw_params["userAgent"])
      assert_equal "Chrome", user_agent.browser
      assert_equal "Macintosh%3B Intel Mac OS X 10_8_2", user_agent.platform
    end

    def test_can_create_payload
      Client.create({identifier: "jumpstartlab", rootUrl: "http://jumpstartlab.com"})
       PayloadCreator.new(params)

      assert_equal 1, PayloadRequest.last.url_id
      assert PayloadRequest.last.requested_at.is_a?(Date)
      assert_equal 37, PayloadRequest.last.responded_in
      assert_equal 1, PayloadRequest.last.referred_by_id
      assert_equal 1, PayloadRequest.last.request_type_id
      assert_equal 1, PayloadRequest.last.event_name_id
      assert_equal 1, PayloadRequest.last.user_agent_id
      assert_equal 1, PayloadRequest.last.resolution_id
      assert_equal 1, PayloadRequest.last.ip_id
      assert_equal 1, PayloadRequest.last.client_id
    end

  end
end
