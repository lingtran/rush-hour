require_relative '../test_helper'

class ParameterTest < Minitest::Test
  include TestHelpers

  def test_parameter_class_can_be_created
    assert Parameter.create({:parameter => ["parameters"]})
  end

end
