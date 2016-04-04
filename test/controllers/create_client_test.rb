require_relative '../test_helper'

module RushHour
  class CreateClientTest < Minitest::Test
    include Rack::Test::Methods
    include TestHelpers
    include AttributeCreator

    def app
      RushHour::Server
    end

    def test_create_a_client_with_valid_attributes
      assert_equal 0, Client.count

      post '/sources', {identifier: "jumpstartlab", rootUrl: "http://jumpstartlab.com" }
      assert_equal 1, Client.count
      assert_equal 200, last_response.status
      assert_equal "Client created", last_response.body
    end

    def test_cannot_create_a_client_with_missing_parameters
      assert_equal 0, Client.count

      post '/sources', {rootUrl: "http://jumpstartlab.com" }
      assert_equal 0, Client.count
      assert_equal 400, last_response.status
      assert_equal "Identifier can't be blank", last_response.body
    end

    def test_cannot_create_a_client_if_identifier_already_exists
      assert_equal 0, Client.count
      Client.create(:identifier => "jumpstartlab", :rootUrl => "http://jumpstartlab.com/")
      assert_equal 1, Client.count
      assert_equal "jumpstartlab", Client.last.identifier

      post '/sources', { identifier: "jumpstartlab", rootUrl: "http://jumpstartlab.com" }
      assert_equal 1, Client.count
      assert_equal "Forbidden!", last_response.body
      assert_equal 403, last_response.status
    end

  end
end
