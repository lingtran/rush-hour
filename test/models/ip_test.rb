require_relative '../test_helper'

module RushHour
  class IpTest < Minitest::Test
    include TestHelpers

    def test_ip_class_can_be_created
      assert Ip.create({:ip => "127.0.0.1"})
      refute Ip.new.valid?
    end

    def test_ip_has_payload_requests
      ip_address = create_ip("127.0.0.1")
      assert_respond_to ip_address, :payload_requests
    end
  end
end
