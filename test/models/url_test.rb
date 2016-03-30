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

end
