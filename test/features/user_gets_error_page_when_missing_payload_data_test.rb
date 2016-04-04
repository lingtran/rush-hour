require_relative '../test_helper.rb'

module RushHour
  class UserGetsErrorPageForMissingPayloadDataTest < Minitest::Test
    include TestHelpers
    include Capybara::DSL

    def test_user_sees_error_page_when_payload_data_is_missing
      create_data
      visit '/sources/petes'
      # assert page.has_content?("Client error page: This client does not exist")
    end
  end
end
