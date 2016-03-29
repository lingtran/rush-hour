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


  def create_payload_requests(num = 1)
    num.times do |i|
      PayloadRequest.create({
        :url       => "url #{i + 1}",
        :requestedAt => "requestedAt #{i + 1}",
        :respondedIn => "respondedIn #{i + 1}",
        :referredBy => "referredBy #{i + 1}",
        :requestType => "requestType #{i + 1}",
        :parameters => "parameters #{i + 1}",
        :eventName => "eventName #{i + 1}",
        :userAgent => "userAgent #{i + 1}",
        :resolutionWidth => "resolutionWidth #{i + 1}",
        :resolutionHeight => "resolutionHeight #{i + 1}",
        :ip => "ip #{i + 1}"
        })
    end
  end

end
