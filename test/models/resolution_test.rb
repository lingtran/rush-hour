require_relative '../test_helper'

class ResolutionTest < Minitest::Test
  include TestHelpers

  def test_resolution_class_can_be_created
    assert Resolution.create({width: "width", height: "height"})
  end

end
