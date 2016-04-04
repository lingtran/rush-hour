module RushHour

  class RequestType < ActiveRecord::Base
    has_many :payload_requests
    validates :verb, presence: true, uniqueness: true


    def self.most_frequent_request_type
      request_frequency = joins(:payload_requests).group(:verb).order("count_all desc").count
      if request_frequency.flatten.empty?
        "teapot"
      else
        request_frequency.max_by { |k,v,| v }.first
      end
    end

    def self.all_http_verbs
      RequestType.all.pluck(:verb).uniq
    end

  end
end
