module RushHour
  class Ip < ActiveRecord::Base
    has_many :payload_requests

    validates :ip, presence: true

  end
end
