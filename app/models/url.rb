module RushHour

  class Url < ActiveRecord::Base
    has_many :payload_requests
    has_many :request_types, through: :payload_requests
    has_many :referred_bies, through: :payload_requests
    has_many :user_agents, through: :payload_requests
    validates :root, presence: true, uniqueness: {scope: :path}



    def all_response_times_for_url_ordered
      payload_requests.pluck(:responded_in).sort.reverse
    end

    def average_response_time_by_url
      responded_ins.average("responded_in").to_f.round(2)
    end

    def http_verbs_for_url
      request_types.pluck("verb").uniq
    end

    def three_most_popular_referrers
      referrers_by_count = referred_bies.group(:root, :path).count
      ranked = referrers_by_count.max_by(3) { |k,v| v }
      ranked.map { |referrer| "#{referrer.first.join("/")}: #{referrer.last}"}
    end

    def three_most_popular_user_agents
      user_agents_by_count = user_agents.group(:os, :browser).count
      ranked = user_agents_by_count.max_by(3) { |k,v| v }
      ranked.map { |user_agent| "#{user_agent.first.join(" ")}: #{user_agent.last}"}
    end
  end
end
