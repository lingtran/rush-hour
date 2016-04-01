
module RushHour
  class Client < ActiveRecord::Base
    has_many :payload_requests

    validates :identifier, presence: true, uniqueness: {scope: :rootUrl}
    validates :rootUrl, presence: true
  end
end
