ENV["RACK_ENV"] ||= "test"

require 'bundler'
Bundler.require

require File.expand_path("../../config/environment", __FILE__)
require 'minitest/autorun'
require 'minitest/pride'
require 'capybara/dsl'
require 'database_cleaner'
require 'pry'

Capybara.app = RushHour::Server

DatabaseCleaner.strategy = :truncation, {except: %w[public.schema_migrations]}

module TestHelpers

  def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end

  def create_url(root, path)
    Url.create({root: root, path: path})
  end

  def create_responded_in(responded_in)
    RespondedIn.create({:responded_in => responded_in})
  end

  def create_referred_by(root, path)
    ReferredBy.create({root: root, path: path})
  end

  def create_request_type(request_type)
    RequestType.create({:verb => request_type})
  end

  def create_event_name(event_name)
    EventName.create({:event_name => event_name})
  end

  def create_user_agent(os, browser)
    UserAgent.create({os: os, browser: browser})
  end

  def create_resolution(width, height)
    Resolution.create({width: width, height: height})
  end

  def create_ip(ip)
    Ip.create({:ip => ip})
  end

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
        :ip_id => create_ip("127.0.0.#{i + 1}").id
        })
    end
  end

end
