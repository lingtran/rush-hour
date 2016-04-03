require_relative '../test_helper.rb'

module RushHour
  class UserCanSeeListOfClientUrlsAndVisitUrlPageTest < Minitest::Test
    include TestHelpers
    include Capybara::DSL


    def test_user_can_see_list_of_urls_specific_to_client_on_client_stats_page
      # skip
      create_data
      visit '/sources/jumpstartlab'
      assert_equal '/sources/jumpstartlab', current_path
      assert page.has_content?("jumpstartlab.com/blog")
      assert page.has_content?("jumpstartlab.com/home")
    end

    def test_user_can_visit_specific_url_of_client_and_be_redirected_to_url_stats_page
      # skip
      create_data
      visit '/sources/jumpstartlab'
      assert_equal '/sources/jumpstartlab', current_path

      click_link("jumpstartlab.com/blog")
      assert '/sources/jumpstartlab/urls/blog', current_path
    end
  end
end
