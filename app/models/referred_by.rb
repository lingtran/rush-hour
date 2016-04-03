
module RushHour
  class ReferredBy < ActiveRecord::Base
    has_many :payload_requests


    validates :root, presence: true, uniqueness: { scope: :path}



  end
end
