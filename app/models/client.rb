
module RushHour
  class Client < ActiveRecord::Base
    has_many :payload_requests
    has_many :request_types, through: :payload_requests

    validates :identifier, presence: true, uniqueness: true
    validates :rootUrl, presence: true
  end

end
