module RushHour

  class UserAgent < ActiveRecord::Base
    has_many :payload_requests
    validates :os, presence: true, uniqueness: {scope: :browser}

    validates :browser, presence: true

  end
end
