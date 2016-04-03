require_relative '../test_helper.rb'

module RushHour
  class UserGetsErrorPageForMissingPayloadDataTest < Minitest::Test
    include TestHelpers
    include Capybara::DSL

    def test_user_sees_error_page_when_payload_data_is_missing
      skip
      # need to feed in missing payload
      # create_data
      # visit '/sources/jumpstartlab'
      # assert page.has_content?("Payload error page: Payload data is missing")
    end
  end
end
