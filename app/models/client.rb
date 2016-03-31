
module RushHour
  class Client < ActiveRecord::Base
    has_many :payload_requests

    validates_uniqueness_of : :identifier, scope: :rootUrl
    validates :identifier, presence: true
    validates :rootUrl, presence: true
  end
end
