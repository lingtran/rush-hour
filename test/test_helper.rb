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
    # 
    # def create_url(root, path)
    #   Url.find_or_create_by({root: root, path: path})
    # end
    #
    # def create_responded_in(responded_in)
    #   RespondedIn.find_or_create_by({:responded_in => responded_in})
    # end
    #
    # def create_referred_by(root, path)
    #   ReferredBy.find_or_create_by({root: root, path: path})
    # end
    #
    # def create_request_type(request_type)
    #   RequestType.find_or_create_by({:verb => request_type})
    # end
    #
    # def create_event_name(event_name)
    #   EventName.find_or_create_by({:event_name => event_name})
    # end
    #
    # def create_user_agent(os, browser)
    #   UserAgent.find_or_create_by({os: os, browser: browser})
    # end
    #
    # def create_resolution(width, height)
    #   Resolution.find_or_create_by({width: width, height: height})
    # end
    #
    # def create_ip(ip)
    #   Ip.find_or_create_by({:ip => ip})
    # end
    #
    # def create_client(identifier, rootUrl)
    #   Client.find_or_create_by({identifier: identifier, rootUrl: rootUrl })
    # end

    def create_payload_requests(num = 1)
      num.times do |i|
        PayloadRequest.create({
          :url_id       => create_url("google.com", "/search#{i + 1}").id,
          :requested_at => Date.new(2016, 01, 01),
          :responded_in_id => create_responded_in(i + 1).id,
          :referred_by_id => create_referred_by("bing.com", "/search#{i + 1}").id,
          :request_type_id => create_request_type("GET").id,
          :event_name_id => create_event_name("eventName #{i + 1}").id,
          :user_agent_id => create_user_agent("OSX#{i + 1}", "Chrome #{i + 1}").id,
          :resolution_id => create_resolution("resolutionWidth #{i + 1}", "resolutionHeight #{i + 1}").id,
          :ip_id => create_ip("127.0.0.#{i + 1}").id,
          :client_id => create_client("jumpstartlab", "http://jumpstartlab.com").id
          })
      end
    end

    def create_payload_specific_url(num = 1)
      num.times do |i|
        PayloadRequest.create({
          :url_id       => create_url("google.com", "/search1").id,
          :requested_at => Date.new(2016, 01, 01),
          :responded_in_id => create_responded_in(i + 1).id,
          :referred_by_id => create_referred_by("bing.com", "/search#{i + 1}").id,
          :request_type_id => create_request_type("GET").id,
          :event_name_id => create_event_name("eventName #{i + 1}").id,
          :user_agent_id => create_user_agent("OSX#{i + 1}", "Chrome #{i + 1}").id,
          :resolution_id => create_resolution("resolutionWidth #{i + 1}", "resolutionHeight #{i + 1}").id,
          :ip_id => create_ip("127.0.0.#{i + 1}").id,
          :client_id => create_client("jumpstartlab", "http://jumpstartlab.com").id

          })
      end
    end

    def params
  {"payload"=>
"{\"url\":\"http://jumpstartlab.com/blog\",\"requestedAt\":\"2013-02-16 21:38:28 -0700\",\"respondedIn\":37,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"GET\",\"parameters\":[],\"eventName\":\"socialLogin\",\"userAgent\":\"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.38.211\"}",
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
