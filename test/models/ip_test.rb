require_relative '../test_helper'

class IpTest < Minitest::Test
  include TestHelpers

  def test_ip_class_can_be_created
    assert Ip.create({:ip => "127.0.0.1"})
  end

end
