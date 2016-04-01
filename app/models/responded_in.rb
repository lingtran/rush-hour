module RushHour

  class RespondedIn < ActiveRecord::Base
    has_many :payload_requests

    validates :responded_in, presence: true, uniqueness: true

  end
end
