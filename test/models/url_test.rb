require_relative '../test_helper'

class UrlTest < Minitest::Test
  include TestHelpers

  def test_url_class_can_be_created
    assert Url.create({root: "google.com", path: "/search"})
  end

end
