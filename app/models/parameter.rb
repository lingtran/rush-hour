class Parameter < ActiveRecord::Base
  has_many :payload_requests

  validates :parameter, presence: true

end
