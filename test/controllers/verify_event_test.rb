require_relative '../test_helper.rb'
module RushHour
  class VerifyEventTest < Minitest::Test
    include Rack::Test::Methods
    include TestHelpers
    include AttributeCreator

    def app
      RushHour::Server
    end

    def test_event_name_for_client_can_be_found
      create_data
      client = Client.find(1)
      get '/sources/turing/events/event1', {:identifier => "turing", :eventname => "event1"}
      assert_equal "turing", Client.find_by(:identifier => "turing").identifier
      assert client.event_names.map { |event| event.event_name }.include?("event1")
    end

    def test_can_get_stats_for_event
      create_data
      client = Client.find(1)
      get '/sources/turing/events/event1', {:identifier => "turing", :eventname => "event1"}
      event_prs = client.event_names.first.payload_requests
      hours = Hash.new(0)
      event_prs.map {|pr| pr.requested_at.hour }.reduce(0) {|sum, element| hours[element] += 1 }

      assert_equal ({19 => 4}), hours
    end

  end
end
