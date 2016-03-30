require_relative '../test_helper'

class UrlTest < Minitest::Test
  include TestHelpers

  def test_url_class_can_be_created
    assert Url.create({:root => "google.com", :path => "search"})
    refute Url.new.valid?
  end

  def test_url_has_payload_requests
    url = create_url("google.com", "search")
    assert_respond_to url, :payload_requests
  end

  def test_max_response_time
    create_payload_requests(1)
    create_payload_requests(2)
    assert_equal 2, Url.max_response_time_by_url("google.com/search2")
    assert_equal 1, Url.max_response_time_by_url("google.com/search1")
  end
end
