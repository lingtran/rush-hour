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
    verbs = Hash.new(0)
    self.all.reduce(0) { |sum, pr| verbs[pr.request_type.verb] += 1}
    verbs.max_by { |k,v| v }.first
  end

  def self.all_http_verbs
    verbs = Hash.new(0)
    self.all.reduce(0) { |sum, pr| verbs[pr.request_type.verb] += 1}
    verbs.keys
  end

  def self.list_of_urls
    urls = Hash.new(0)
    self.all.reduce(0) { |sum, pr| urls[pr.url.root + pr.url.path] += 1}
    urls.sort_by {|k,v| v}.map { |i| i[0] }.reverse
  end

end
