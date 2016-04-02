
module RushHour
  class Client < ActiveRecord::Base
    has_many :payload_requests

    validates :identifier, presence: true, uniqueness: true
    validates :rootUrl, presence: true
  end

  def self.response_time_all_requests
    self.payload_requests.average_response_time
  end
end
