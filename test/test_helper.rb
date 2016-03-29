ENV["RACK_ENV"] ||= "test"

require 'bundler'
Bundler.require

require File.expand_path("../../config/environment", __FILE__)
require 'minitest/autorun'
require 'minitest/pride'
require 'capybara/dsl'

Capybara.app = RushHour::Server


module TestHelpers

  def teardown
    PayloadRequest.destroy_all
  end

  def create_url(url)
    Url.create({:url => url})
  end

  def create_responded_in(responded_in)
    RespondedIn.create({:responded_in => responded_in})
  end

  def create_referred_by(referred_by)
    ReferredBy.create({:referred_by => referred_by})
  end

  def create_request_type(request_type)
    RequestType.create({:request_type => request_type})
  end

  def create_parameters(parameters)
    Parameter.create({:parameters => parameters})
  end

  def create_event_name(event_name)
    EventName.create({:event_name => event_name})
  end

  def create_user_agent(user_agent)
    UserAgent.create({:user_agent => user_agent})
  end

  def create_resolution(resolution)
    Resolution.create({:resolution => resolution})
  end

  def create_ip(ip)
    Ip.create({:ip => ip})
  end

  def create_payload_requests(num = 1)
    num.times do |i|
      PayloadRequest.create({
        :url_id       => create_url("url #{i + 1}").id,
        :requested_at => Date.new(2016, 01, 01),
        :responded_in_id => create_responded_in("respondedIn #{i + 1}").id,
        :referred_by_id => create_referred_by("referredBy #{i + 1}").id,
        :request_type_id => create_request_type("requestType #{i + 1}").id,
        :parameters_id => create_parameters("parameters #{i + 1}").id,
        :event_name_id => create_event_name("eventName #{i + 1}").id,
        :user_agent_id => create_user_agent("userAgent #{i + 1}").id,
        :resolution_id => create_resolution("resolutionWidth #{i + 1}").id,
        :ip_id => create_id("127.0.0.#{i}").id
        })
    end
  end

end
