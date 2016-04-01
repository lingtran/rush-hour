module RushHour

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
    validates_uniqueness_of :client_id, scope: [:url_id,
                                               :requested_at,
                                               :responded_in_id,
                                               :referred_by_id,
                                               :request_type_id,
                                               :event_name_id,
                                               :user_agent_id,
                                               :resolution_id,
                                               :ip_id]

    def self.average_response_time
      joins(:responded_in).average(:responded_in)
    end

    def self.max_response_time
      joins(:responded_in).maximum(:responded_in)
    end

    def self.min_response_time
      joins(:responded_in).minimum(:responded_in)
    end

    def self.list_of_urls
      joins(:url).pluck(:root, :path).map { |url| url.join }.uniq
    end

    def self.web_browser_breakdown
      joins(:user_agent).pluck(:browser).uniq
    end

    def self.os_breakdown
      joins(:user_agent).pluck(:os).uniq
    end

    def self.resolution_breakdown
      joins(:resolution).pluck(:width, :height).map { |res| res.join(" x ")}
    end



  end
end
