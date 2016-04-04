require_relative '../test_helper'
# require_relative '../../app/models/payload_creator'
# require 'pry'

module RushHour
  class CreatePayloadTest < Minitest::Test
    include Rack::Test::Methods
    include TestHelpers
    include AttributeCreator

    def app
      RushHour::Server
    end

    def test_client_cannot_be_found
      assert_equal 0, Client.count
      post '/sources/jumpstartlab/data', { payload: params["payload"], identifier: params["identifier"]}
      assert_equal 403, last_response.status
      assert_equal "Client jumpstartlab does not exist.", last_response.body
      assert_equal 0, Client.count
    end

    def test_payload_request_with_valid_attributes_and_uniqueness_can_be_created
      Client.create(:identifier => params["identifier"], :rootUrl => params["rootUrl"])
      assert_equal 1, Client.count

      post '/sources/jumpstartlab/data', { payload: params["payload"] }
      assert_equal 200, last_response.status
      assert_equal "It's all good", last_response.body
    end

    def test_client_payload_request_has_already_been_received
      Client.create(:identifier => params["identifier"], :rootUrl => params["rootUrl"])

      post '/sources/jumpstartlab/data', { payload: params["payload"], identifier: params["identifier"] }
      assert_equal 1, PayloadRequest.find_by(:responded_in => 37).id
      assert_equal 1, Client.count
      assert_equal 1, PayloadRequest.count

      post '/sources/jumpstartlab/data', { payload: params["payload"], identifier: params["identifier"] }
      assert_equal 403, last_response.status
      assert_equal "Jumpstartlab: this request already exists.", last_response.body
      assert_equal 1, PayloadRequest.find_by(:responded_in => 37).id
    end

    def test_missing_payload_can_be_detected
      Client.create(:identifier => params["identifier"], :rootUrl => params["rootUrl"])
      post '/sources/jumpstartlab/data', params_missing
      assert_equal 400, last_response.status
      assert_equal "Url can't be blank", last_response.body
    end
  end
end
