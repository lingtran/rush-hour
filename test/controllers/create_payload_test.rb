require_relative '../test_helper'
require 'pry'

class CreatePayloadTest < Minitest::Test
  include Rack::Test::Methods
  include TestHelpers

  def app
    RushHour::Server
  end

  def test_client_cannot_be_found
    assert_equal 0, Client.count
    post '/sources/jumpstartlab/data'
    assert_equal 403, last_response.status
    assert_equal "Application Not Registered", last_response.body
    # create_client("jumpstartlab", "http://jumpstartlab.com")
    # post '/sources/jumpstartlab/data'
    # assert_equal 1, Client.count
  end

  def test_payload_request_can_be_created_with_valid_attributes
    create_client("jumpstartlab", "jumpstartlab.com")
    sample_payload = { url:"http://jumpstartlab.com/blog",
                      requestedAt:"2013-02-16 21:38:28 -0700",
                      respondedIn:37,
                      referredBy:"http://jumpstartlab.com",
                      requestType:"GET",
                      parameters:[],
                      eventName:"socialLogin",
                      userAgent:"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                      resolutionWidth:"1920",
                      resolutionHeight:"1280",
                      ip:"63.29.38.211"
                      }
    post '/sources/jumpstartlab/data', sample_payload
    prl = PayloadRequest.last
    assert_equal 200, last_response.status
    assert_equal "OK", last_response.body
    assert_equal 1, PayloadRequest.count
    assert_equal "jumpstartlab.com", prl.url.root
    assert_equal "/blog", prl.url.path
    assert_equal Date.strptime("2013-02-16 21:38:28 -0700", "%Y-%m-%d %H:%M:%S %Z"), prl.requested_at.requested_at
    assert_equal 37, prl.responded_in.responded_in
    assert_equal "jumpstartlab.com", prl.referred_by.root
    assert_equal "", prl.referred_by.path
    assert_equal "GET", prl.request_type.verb
    assert_equal "socalLogin", prl.event_name.event_name
    # assert_equal "Mozilla", prl.user_agent.browser
    # assert_equal "OSX", prl.user_agent.os
    assert_equal "1920", prl.resolution.width
    assert_equal "1280", prl.resolution.height
    assert_equal "63.2938.211", prl.ip.ip
  end


end
