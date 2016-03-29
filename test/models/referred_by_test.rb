require_relative '../test_helper'

class ReferredByTest < Minitest::Test
  include TestHelpers

  def test_referred_by_class_can_be_created
    assert ReferredBy.create({:root => "www.google.com", :path => "/gmail"})
    refute ReferredBy.new.valid?
  end

  def test_referred_by_has_payload_requests
    referred_by = create_referred_by("www.google.com", "/gmail")
    assert_respond_to referred_by, :payload_requests
  end

end
