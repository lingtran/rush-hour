require_relative '../test_helper'

class ReferredByTest < Minitest::Test
  include TestHelpers

  def test_referred_by_class_can_be_created
    assert ReferredBy.create({:root => "www.google.com", :path => "/gmail"})
  end

end
