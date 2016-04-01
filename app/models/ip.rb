module RushHour
  class Ip < ActiveRecord::Base
    has_many :payload_requests

    validates :ip, presence: true, uniqueness: true

  end
end
