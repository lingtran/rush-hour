module RushHour
  class EventName < ActiveRecord::Base
    has_many :payload_requests

    validates :event_name, presence: true

  end
end 
