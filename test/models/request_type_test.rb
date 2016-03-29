require_relative '../test_helper'

class RequestTypeTest < Minitest::Test
  include TestHelpers

  def test_request_type_class_can_be_created
    assert RequestType.create({:verb => "GET"})
  end

end
