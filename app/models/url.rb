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

  def average_response_time_by_url
    # payload_requests.
  end

  # def self.url_parser(url)
  #   split = Hash.new
  #   initial_split = url.split("/")
  #   split[:root] = initial_split[0]
  #   split[:path] = "/#{initial_split[1]}"
  #   split
  # end
end
