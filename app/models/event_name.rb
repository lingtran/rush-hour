module RushHour
  class EventName < ActiveRecord::Base
    has_many :payload_requests
    

    validates :event_name, presence: true, uniqueness: true

    def self.ordered_events
      joins(:payload_requests).group(:event_name).order("count_all desc").count
    end




  end

end
