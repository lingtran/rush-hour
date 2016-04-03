require_relative '../test_helper'
module RushHour
  class UserAgentTest < Minitest::Test
    include TestHelpers
    include AttributeCreator

    def test_user_agent_class_can_be_created_but_not_duplicated_or_blank
      assert UserAgent.create({:os => "osX", :browser => "chrome"})
      refute UserAgent.new.valid?
      refute UserAgent.new({:os => "osX", :browser => "chrome"}).save
    end

    def test_user_agent_has_payload_requests
      user_agent = create_user_agent("osX", "chrome")
      assert_respond_to user_agent, :payload_requests
    end
  end
end
