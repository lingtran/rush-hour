require_relative '../test_helper'

module RushHour
  class RequestTypeTest < Minitest::Test
    include TestHelpers
    include AttributeCreator

    def test_request_type_class_can_be_created_but_not_duplicated_or_blank
      assert RequestType.create({:verb => "Get"})
      refute RequestType.new.valid?
      refute RequestType.new({:verb => "Get"}).save
    end

    def test_request_type_has_payload_requests
      request_type = create_request_type("Get")
      assert_respond_to request_type, :payload_requests
    end

    def test_most_frequent_request_type
      create_data
      assert_equal "POST", RequestType.most_frequent_request_type
    end

  end

  def test_list_of_all_HTTP_verbs_used
    create_data

    assert_equal ["GET", "POST"], RequestType.all_http_verbs
  end

end
