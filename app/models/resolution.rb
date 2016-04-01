module RushHour

  class Resolution < ActiveRecord::Base
    has_many :payload_requests
    validates :height, presence: true, uniqueness: {scope: :width}
    validates :width, presence: true


  end
end
