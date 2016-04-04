ENV["RACK_ENV"] ||= "test"

require 'bundler'
Bundler.require

require File.expand_path("../../config/environment", __FILE__)
require 'minitest/autorun'
require 'minitest/pride'
require 'capybara/dsl'
require 'database_cleaner'
require 'pry'
require 'ipaddr'
require 'tilt/erb'

Capybara.app = RushHour::Server

DatabaseCleaner.strategy = :truncation, {except: %w[public.schema_migrations]}
module RushHour
  module TestHelpers

    def setup
      DatabaseCleaner.start
    end

    def teardown
      DatabaseCleaner.clean
    end

    def create_data
      @resolution1 = Resolution.create({width: "1920", height: "1280"})
      @resolution2 = Resolution.create({width: "800", height: "640"})

      @request_type1 = RequestType.create({verb: "GET"})
      @request_type2 = RequestType.create({verb: "POST"})

      @event1 = EventName.create({event_name: "event1"})
      @event2 = EventName.create({event_name: "event2"})
      @event3 = EventName.create({event_name: "event3"})

      @agent1 = UserAgent.create({browser: "Chrome", os: "Macintosh"})
      @agent2 = UserAgent.create({browser: "Safari", os: "Macintosh"})
      @agent3 = UserAgent.create({browser: "Mozilla", os: "Windows"})

      @url1 = Url.create({root: "jumpstartlab.com", path: "blog"})
      @url2 = Url.create({root: "jumpstartlab.com", path: "exam"})
      @url3 = Url.create({root: "jumpstartlab.com", path: "home"})

      @referral1 = ReferredBy.create({root: "jumpstartlab.com", path: "path1"})
      @referral2 = ReferredBy.create({root: "jumpstartlab.com", path: "path2"})
      @referral3 = ReferredBy.create({root: "jumpstartlab.com", path: "path3"})

      @client1 = Client.create({identifier: "turing", rootUrl: "http://turing.io"})
      @client2 = Client.create({identifier: "jumpstartlab", rootUrl: "http://jumpstartlab.com"})
      @client3 = Client.create({identifier: "petes", rootUrl:"http://petes.com"})

      @ip1 = Ip.create({ip: "127.0.0.1"})
      @ip2 = Ip.create({ip: "127.0.0.2"})
      @ip3 = Ip.create({ip: "127.0.0.3"})

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

      payload2 = {
          url_id: @url3.id,
          requested_at: "2015-04-01 12:30:40 -700",
          responded_in: 61,
          referred_by_id: @referral2.id,
          request_type_id: @request_type2.id,
          event_name_id: @event2.id,
          user_agent_id: @agent2.id,
          resolution_id: @resolution2.id,
          ip_id: @ip2.id,
          client_id: @client2.id
      }

      payload3 = {
          url_id: @url2.id,
          requested_at: "2015-04-01 12:40:40 -700",
          responded_in: 62,
          referred_by_id: @referral3.id,
          request_type_id: @request_type2.id,
          event_name_id: @event1.id,
          user_agent_id: @agent2.id,
          resolution_id: @resolution2.id,
          ip_id: @ip3.id,
          client_id: @client1.id
      }

      payload4 = {
          url_id: @url3.id,
          requested_at: "2015-04-01 12:50:40 -700",
          responded_in: 61,
          referred_by_id: @referral3.id,
          request_type_id: @request_type1.id,
          event_name_id: @event3.id,
          user_agent_id: @agent3.id,
          resolution_id: @resolution1.id,
          ip_id: @ip1.id,
          client_id: @client2.id
      }

      payload5 = {
          url_id: @url2.id,
          requested_at: "2015-04-01 12:10:40 -700",
          responded_in: 62,
          referred_by_id: @referral3.id,
          request_type_id: @request_type2.id,
          event_name_id: @event2.id,
          user_agent_id: @agent2.id,
          resolution_id: @resolution2.id,
          ip_id: @ip2.id,
          client_id: @client1.id
      }

      payload6 = {
          url_id: @url1.id,
          requested_at: "2015-04-01 12:30:20 -700",
          responded_in: 65,
          referred_by_id: @referral2.id,
          request_type_id: @request_type1.id,
          event_name_id: @event1.id,
          user_agent_id: @agent3.id,
          resolution_id: @resolution2.id,
          ip_id: @ip1.id,
          client_id: @client2.id
      }

      payload7 = {
          url_id: @url2.id,
          requested_at: "2015-04-01 12:30:30 -700",
          responded_in: 62,
          referred_by_id: @referral1.id,
          request_type_id: @request_type2.id,
          event_name_id: @event1.id,
          user_agent_id: @agent3.id,
          resolution_id: @resolution1.id,
          ip_id: @ip3.id,
          client_id: @client1.id
      }

      payload8 = {
          url_id: @url3.id,
          requested_at: "2015-04-01 12:30:42 -700",
          responded_in: 65,
          referred_by_id: @referral2.id,
          request_type_id: @request_type1.id,
          event_name_id: @event2.id,
          user_agent_id: @agent3.id,
          resolution_id: @resolution1.id,
          ip_id: @ip3.id,
          client_id: @client2.id
      }

      @payload_request1 = PayloadRequest.create(payload1)
      @payload_request2 = PayloadRequest.create(payload2)
      @payload_request3 = PayloadRequest.create(payload3)
      @payload_request4 = PayloadRequest.create(payload4)
      @payload_request5 = PayloadRequest.create(payload5)
      @payload_request6 = PayloadRequest.create(payload6)
      @payload_request7 = PayloadRequest.create(payload7)
      @payload_request8 = PayloadRequest.create(payload8)
    end

    def params
  {"payload"=>
"{\"url\":\"http://jumpstartlab.com/blog\",\"requestedAt\":\"2013-02-16 21:38:28 -0700\",\"respondedIn\":37,\"referredBy\":\"http://jumpstartlab.com/blog\",\"requestType\":\"GET\",\"parameters\":[],\"eventName\":\"socialLogin\",\"userAgent\":\"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.38.211\"}",
"splat"=>[],
"captures"=>["jumpstartlab1"],
"identifier"=>"jumpstartlab",
    "rootUrl"=>"http://jumpstartlab.com"}
    end

    def params_two
      {"payload"=>
      "{\"url\":\"http://jumpstartlab.com/blog\",\"requestedAt\":\"2013-02-16 21:38:28 -0700\",\"respondedIn\":37,\"referredBy\":\"http://jumpstartlab.com/blog\",\"requestType\":\"GET\",\"parameters\":[],\"eventName\":\"socialLogin\",\"userAgent\":\"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.38.211\"}",
      "splat"=>[],
      "captures"=>["jumpstartlab1"],
      "identifier"=>"jumpstartlab",
      "rootUrl"=>"http://jumpstartlab.com"}
    end

    def params_three
      {"payload"=>
        "{\"url\":\"http://yahoo.com/news\",\"requestedAt\":\"2013-01-14 17:38:28 -0700\",\"respondedIn\":55,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"POST\",\"parameters\":[\"slow\"],\"eventName\":\"\"beginRegistration\",\"userAgent\":\"Mozilla/3.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"800\",\"resolutionHeight\":\"600\",\"ip\":\"63.29.38.214\"}",
        "splat"=>[],
        "captures"=>["yahoo"],
        "identifier"=>["yahoo"],
        "rootUrl"=>"http://yahoo.com"}
    end


    def params_missing
  {"payload"=>
  "{\"url\":\"\",\"requestedAt\":\"2013-02-16 21:38:28 -0700\",\"respondedIn\":37,\"referredBy\":\"http://jumpstartlab.com/blog\",\"requestType\":\"GET\",\"parameters\":[],\"eventName\":\"socialLogin\",\"userAgent\":\"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.38.211\"}",
  "splat"=>[],
  "captures"=>["jumpstartlab1"],
  "identifier"=>"jumpstartlab1",
    "rootUrl"=>"http://jumpstartlab.com"}
    end


    def payload_data
      {
        url:"http://jumpstartlab.com/blog",
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
      }.to_json
    end

  end
end
