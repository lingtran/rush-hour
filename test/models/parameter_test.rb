require_relative '../test_helper'

class ParameterTest < Minitest::Test
  include TestHelpers

  def test_parameter_class_can_be_created
    assert Parameter.create({:parameter => ["parameters"]})
    refute Parameter.new.valid?
  end

  def test_parameter_has_payload_requests
    parameter = create_parameters(["parameters 123"])
    assert_respond_to parameter, :payload_requests
  end

end
