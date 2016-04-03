require_relative '../test_helper.rb'

module RushHour
  class UserGetsErrorPageWithMissingIdentifierTest < Minitest::Test
    include TestHelpers
    include Capybara::DSL

    def test_user_sees_error_page_when_identifier_does_not_exist
      create_data
      visit '/sources/junglebeats'
      assert page.has_content?("Client error page: This client does not exist")
    end
  end
end
