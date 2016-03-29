class ReferredBy < ActiveRecord::Base
  has_many :payload_requests

  validates :root, presence: true
  validates :path, presence: true


end
