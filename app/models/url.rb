class Url < ActiveRecord::Base
  has_many :payload_requests
  validates :root, presence: true
  validates :path, presence: true

  def max_response_time_by_url
    get_responded_ins_for_url.max
  end

  def min_response_time_by_url
    get_responded_ins_for_url.min
  end

  def get_responded_ins_for_url
    # split = Url.url_parser(url)
    # result = self.find_by(:root => split[:root], :path => split[:path])
    # PayloadRequest.where(:url_id => result.id).map do |pr|
    #   pr.responded_in.responded_in
    # end
    payload_requests.map { |pr| pr.responded_in.responded_in }
  end


  # def self.url_parser(url)
  #   split = Hash.new
  #   initial_split = url.split("/")
  #   split[:root] = initial_split[0]
  #   split[:path] = "/#{initial_split[1]}"
  #   split
  # end

  def self.all_response_times_for_url_ordered(url)
    Url.get_responded_ins_for_url(url).sort.reverse
  end

  def self.average_response_time_by_url(url)
    response_times = Url.get_responded_ins_for_url(url)
    response_times.reduce(:+)/response_times.count
  end

  def self.http_verbs_for_url(url)
    split = Url.url_parser(url)
    result = self.find_by(:root => split[:root], :path => split[:path])
    PayloadRequest.where(:url_id => result.id).map do |pr|
      pr.request_type.verb
    end.uniq
  end

  def self.three_most_popular_referrers(url)
    split = Url.url_parser(url)
    referred_bies = Hash.new(0)
    result = self.find_by(:root => split[:root], :path => split[:path])
    PayloadRequest.where(:url_id => result.id).reduce(0)do |sum, pr|
      referred_bies[pr.referred_by.root + pr.referred_by.path] += 1
    end
    referred_bies.sort_by { |k,v| v }.reverse.take(3).map { |x| x.first }
  end

  def self.three_most_popular_user_agents(url)
    split = Url.url_parser(url)
    user_agents = Hash.new(0)
    result = self.find_by(:root => split[:root], :path => split[:path])

    PayloadRequest.where(:url_id => result.id).reduce(0)do |sum, pr|
      user_agents["#{pr.user_agent.os} #{pr.user_agent.browser}"] += 1
    end
    user_agents.sort_by { |k,v| v }.reverse.take(3).map { |x| x.first }
  end
end
