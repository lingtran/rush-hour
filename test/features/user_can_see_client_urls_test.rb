require_relative '../test_helper.rb'

module RushHour
  class UserCanSeeListOfClientUrlsAndVisitUrlPageTest < Minitest::Test
    include TestHelpers
    include Capybara::DSL


    def test_user_can_see_list_of_urls_specific_to_client_on_client_stats_page
      create_data
      visit '/sources/jumpstartlab'
      assert_equal '/sources/jumpstartlab', current_path
      assert page.has_link?("jumpstartlab.com/blog")
      assert page.has_link?("jumpstartlab.com/home")
    end

    def test_user_can_visit_specific_url_of_client_and_be_redirected_to_url_stats_page
      create_data
      visit '/sources/jumpstartlab'
      assert_equal '/sources/jumpstartlab', current_path
      assert page.has_link?('jumpstartlab.com/blog')

      click_link("jumpstartlab.com/blog")
      assert '/sources/jumpstartlab/urls/blog', current_path
    end
  end
end
