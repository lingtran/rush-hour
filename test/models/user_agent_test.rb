require_relative '../test_helper'

class UserAgentTest < Minitest::Test
  include TestHelpers

  def test_user_agent_class_can_be_created
    assert UserAgent.create({:os => "osX", :browser => "chrome"})
    refute UserAgent.new.valid?
  end

  def test_user_agent_has_payload_requests
    user_agent = create_user_agent("osX", "chrome")
    assert_respond_to user_agent, :payload_requests
  end
end
