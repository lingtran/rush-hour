require_relative '../test_helper'

class UserAgentTest < Minitest::Test
  include TestHelpers

  def test_user_agent_class_can_be_created
    assert UserAgent.create({os: "OSX", browser: "Chrome"})
  end

end
