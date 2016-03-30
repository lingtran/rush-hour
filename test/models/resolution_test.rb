require_relative '../test_helper'

class ResolutionTest < Minitest::Test
  include TestHelpers

  def test_resolution_class_can_be_created
    assert Resolution.create({:width => "800", :height => "600"})
    refute Resolution.new.valid?
  end

  def test_resoltuion_has_payload_requests
    resolution = create_resolution("800", "600")
    assert_respond_to resolution, :payload_requests
  end

end
