module RushHour

  class PayloadRequest < ActiveRecord::Base
    include PayloadCreator

    belongs_to :client
    belongs_to :url
    belongs_to :request_type
    belongs_to :referred_by
    belongs_to :event_name
    belongs_to :user_agent
    belongs_to :resolution
    belongs_to :ip

    validates :url_id, presence: true
    validates :requested_at, presence: true
    validates :responded_in, presence: true
    validates :referred_by_id, presence: true
    validates :request_type_id, presence: true
    validates :event_name_id, presence: true
    validates :user_agent_id, presence: true
    validates :resolution_id, presence: true
    validates :ip_id, presence: true
    validates :client_id, presence: true
    validates_uniqueness_of :client_id, scope: [:url_id,
                                               :requested_at,
                                               :responded_in,
                                               :referred_by_id,
                                               :request_type_id,
                                               :event_name_id,
                                               :user_agent_id,
                                               :resolution_id,
                                               :ip_id]

    def self.average_response_time
      average(:responded_in).to_f.round(2)
      # test
    end

    def self.max_response_time
      maximum(:responded_in)
      # test
    end

    def self.min_response_time
      minimum(:responded_in)
      # test
    end

    def self.list_of_urls_unique
      # test is in url_test and not in payload_request_one => move this method or move the test? or neither?
      joins(:url).pluck(:root, :path).map { |url| url.join("/") }.uniq
    end

    def self.list_of_url_paths
      joins(:url).pluck(:path).uniq
    end
    
    def self.list_of_urls_ranked
      joins(:url).group(:root, :path).order("count_all desc").count.map{ |k, v| k.join("/")}
    end

    def self.web_browser_breakdown
      joins(:user_agent).pluck(:browser).uniq
    end

    def self.os_breakdown
      joins(:user_agent).pluck(:os).uniq
    end

    def self.resolution_breakdown
      joins(:resolution).pluck(:width, :height).map { |res| res.join(" x ")}.uniq
    end
  end
end
