class Url < ActiveRecord::Base
  has_many :payload_requests
  validates :root, presence: true
  validates :path, presence: true

  def self.max_response_time_by_url(url)
    split = Url.url_parser(url)
    result = self.find_by(:root => split[:root], :path => split[:path])
    PayloadRequest.where(:url_id => result.id).map do |pr|
      pr.responded_in.responded_in
    end.max
  end

  def self.url_parser(url)
    split = Hash.new
    initial_split = url.split("/")
    split[:root] = initial_split[0]
    split[:path] = "/#{initial_split[1]}"
    split
  end
end
