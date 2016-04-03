require_relative '../test_helper'

module RushHour
  class ResolutionTest < Minitest::Test
    include TestHelpers
    include AttributeCreator

    def test_resolution_class_can_be_created_but_not_duplicated_or_blank
      assert Resolution.create({:width => "800", :height => "600"})
      refute Resolution.new.valid?
      refute Resolution.new({:width => "800", :height => "600"}).save
    end

    def test_resolution_has_payload_requests
      resolution = create_resolution("800", "600")
      assert_respond_to resolution, :payload_requests
    end

  end
end
