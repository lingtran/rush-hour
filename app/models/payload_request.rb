class PayloadRequest < ActiveRecord::Base
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

  def self.average_response_time
    RespondedIn.average(:responded_in)
  end

  def self.max_response_time
    RespondedIn.maximum(:responded_in)
  end

  def self.min_response_time
    RespondedIn.minimum(:responded_in)
  end

  def self.most_frequent_request_type
    RequestType.find(self.maximum(:request_type_id))
    # verbs = Hash.new(0)
    # self.all.reduce(0) { |sum, pr| verbs[pr.request_type.verb] += 1}
    # verbs.max_by { |k,v| v }.first
  end

  def self.all_http_verbs
    RequestType.all
    # verbs = Hash.new(0)
    # self.all.reduce(0) { |sum, pr| verbs[pr.request_type.verb] += 1}
    # verbs.keys
  end

  def self.list_of_urls
    Url.all.map do |url|
      [url.root, url.path].join()
    end
    # urls = Hash.new(0)
    # self.all.reduce(0) { |sum, pr| urls[pr.url.root + pr.url.path] += 1}
    # urls.sort_by {|k,v| v}.map { |i| i[0] }.reverse
  end

  def self.web_browser_breakdown
    browsers = Hash.new(0)
    self.all.reduce(0) { |sum, pr| browsers[pr.user_agent.browser] += 1}
    browsers.keys
  end

  def self.osx_breakdown
    oss = Hash.new(0)
    self.all.reduce(0) { |sum, pr| oss[pr.user_agent.os] += 1}
    oss.keys
  end

  def self.resolution_breakdown
    resolutions = Hash.new(0)
    self.all.reduce(0) { |sum, pr| resolutions["#{pr.resolution.width} x #{pr.resolution.height}"] += 1}
    resolutions.keys
  end

  def self.ordered_events
    ordered_events = Hash.new(0)
    self.all.reduce(0) {|sum, pr| ordered_events[pr.event_name.event_name] += 1}
    ordered_events.sort_by { |k,v| v }.map { |i| i[0]}.reverse
  end

end
