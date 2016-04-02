
module RushHour
  class Client < ActiveRecord::Base
    has_many :payload_requests

    has_many :responded_ins, through: :payload_requests
    has_many :request_types, through: :payload_requests
    has_many :referred_bies, through: :payload_requests
    has_many :user_agents, through: :payload_requests

    validates :identifier, presence: true, uniqueness: true
    validates :rootUrl, presence: true
  end

  def self.response_time_all_requests
    self.payload_requests.average_response_time
  end
end
