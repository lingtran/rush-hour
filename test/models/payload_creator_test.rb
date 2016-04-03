require_relative '../test_helper'
require 'pry'
module RushHour
  class PayloadCreatorTest < Minitest::Test
    include Rack::Test::Methods
    include TestHelpers
    include PayloadCreator

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

    def test_can_parse_params

      result = {:url=>"http://jumpstartlab.com/blog",
      :requestedAt=>"2013-02-16 21:38:28 -0700",
      :respondedIn=>37,
      :referredBy=>"http://jumpstartlab.com/blog",
      :requestType=>"GET",
      :parameters=>[],
      :eventName=>"socialLogin",
      :userAgent=>"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
      :resolutionWidth=>"1920",
      :resolutionHeight=>"1280",
      :ip=>"63.29.38.211"}
      assert_equal result, params_parser(params)
    end

    def test_can_parse_url
      parsed_params = params_parser(params)
      new_url = parse_url(parsed_params[:url])
      assert_equal "jumpstartlab.com", new_url[:root]
      assert_equal "blog", new_url[:path]
    end

    def test_user_agent_can_be_parsed_with_user_agent_gem
      parsed_params = params_parser(params)
      raw_user_agent = parsed_params[:userAgent]

      user_agent = parse_user_agent(raw_user_agent)
      assert_equal "Chrome", user_agent.browser
      assert_equal "Macintosh%3B Intel Mac OS X 10_8_2", user_agent.platform
    end

    def test_can_create_payload
      Client.create({identifier: "jumpstartlab", rootUrl: "jumpstartlab.com"})

      payload = create_payload(params, params["identifier"])
      assert_equal 1, payload.url_id
      assert payload.requested_at.is_a?(Date)
      assert_equal 37, payload.responded_in
      assert_equal 1, payload.referred_by_id
      assert_equal 1, payload.request_type_id
      assert_equal 1, payload.event_name_id
      assert_equal 1, payload.user_agent_id
      assert_equal 1, payload.resolution_id
      assert_equal 1, payload.ip_id
      assert_equal 1, payload.client_id
    end

  end
end
