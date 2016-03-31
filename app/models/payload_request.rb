class PayloadRequest < ActiveRecord::Base
  belongs_to :client
  belongs_to :url
  belongs_to :request_type
  belongs_to :responded_in
  belongs_to :referred_by
  belongs_to :event_name
  belongs_to :user_agent
  belongs_to :resolution
  belongs_to :ip

  validates :url_id, presence: true
  validates :requested_at, presence: true
  validates :responded_in_id, presence: true
  validates :referred_by_id, presence: true
  validates :request_type_id, presence: true
  validates :event_name_id, presence: true
  validates :user_agent_id, presence: true
  validates :resolution_id, presence: true
  validates :ip_id, presence: true
  validates :client_id, presence: true

  def self.average_response_time
    joins(:responded_in).average(:responded_in)
  end

  def self.max_response_time
    joins(:responded_in).maximum(:responded_in)
  end

  def self.min_response_time
    joins(:responded_in).minimum(:responded_in)
  end

  def self.most_frequent_request_type
    # request type model
    request_frequency = self.group(:request_type_id).count
    most_frequent = request_frequency.max_by { |k,v| v }
    RequestType.find(most_frequent.first).verb
  end

  def self.all_http_verbs
    RequestType.all
  end

  def self.list_of_urls
    Url.pluck(:root, :path).map { |url| url.join }
  end

  def self.web_browser_breakdown
    UserAgent.pluck(:browser).uniq
  end

  def self.os_breakdown
    UserAgent.pluck(:os).uniq
  end

  def self.resolution_breakdown
    Resolution.pluck(:width, :height).map { |res| res.join(" x ")}
  end

  def self.ordered_events
    # EventName.joins(:payload_requests).group(:event_name).order("count_all desc").count
  end

end
