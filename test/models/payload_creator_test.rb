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
      assert PayloadRequest.last.requested_at.is_a?(Time)
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
