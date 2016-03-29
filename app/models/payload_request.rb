class PayloadRequest < ActiveRecord::Base
  belongs_to :url
  belongs_to :request_type
  belongs_to :responded_in
  belongs_to :referred_by
  belongs_to :parameter
  belongs_to :event_name
  belongs_to :user_agent
  belongs_to :resolution
  belongs_to :ip

  validates :url_id, presence: true
  validates :requested_at_id, presence: true
  validates :responded_in_id, presence: true
  validates :referred_by_id, presence: true
  validates :request_type_id, presence: true
  validates :parameters_id, presence: true
  validates :event_name_id, presence: true
  validates :user_agent_id, presence: true
  validates :resolution_id, presence: true
  validates :ip_id, presence: true
end
