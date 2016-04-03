require_relative '../test_helper'

module RushHour
  class ReferredByTest < Minitest::Test
    include TestHelpers
    include AttributeCreator

    def test_referred_by_class_can_be_created_but_not_duplicated_or_blank
      assert ReferredBy.create({:root => "www.google.com", :path => "/gmail"})
      refute ReferredBy.new.valid?
      refute ReferredBy.new({:root => "www.google.com", :path => "/gmail"}).save
    end

    def test_referred_by_has_payload_requests
      referred_by = create_referred_by("www.google.com", "/gmail")
      assert_respond_to referred_by, :payload_requests
    end

  end
end
