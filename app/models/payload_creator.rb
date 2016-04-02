module PayloadCreator

  def create_url(root, path)
    RushHour::Url.find_or_create_by({root: root, path: path})
  end

  def create_referred_by(root, path)
    RushHour::ReferredBy.find_or_create_by({root: root, path: path})
  end

  def create_request_type(request_type)
    RushHour::RequestType.find_or_create_by({:verb => request_type})
  end

  def create_event_name(event_name)
    RushHour::EventName.find_or_create_by({:event_name => event_name})
  end

  def create_user_agent(os, browser)
    RushHour::UserAgent.find_or_create_by({os: os, browser: browser})
  end

  def create_resolution(width, height)
    RushHour::Resolution.find_or_create_by({width: width, height: height})
  end

  def create_ip(ip)
    RushHour::Ip.find_or_create_by({:ip => ip})
  end

  def create_payload(params_payload, params_identifier=nil)
    params = params_parser(params_payload)
    new_url = parse_url(params[:url])
    new_referred_by = parse_url(params[:referredBy])
    new_user_agent = parse_user_agent(params[:userAgent])
    payload = RushHour::PayloadRequest.new({
      :url_id       => create_url(new_url[:root], new_url[:path]).id,
      :requested_at => Date.strptime(params[:requestedAt], "%F %H:%M:%S"),
      :responded_in => params[:respondedIn],
      :referred_by_id => create_referred_by(new_referred_by[:root], new_referred_by[:path]).id,
      :request_type_id => create_request_type(params[:requestType]).id,
      :event_name_id => create_event_name(params[:eventName]).id,
      :user_agent_id => create_user_agent(new_user_agent.platform, new_user_agent.browser).id,
      :resolution_id => create_resolution(params[:resolutionWidth], params[:resolutionHeight]).id,
      :ip_id => create_ip(params[:ip]).id,
      :client_id => RushHour::Client.find_by(:identifier => params_identifier) == nil ? nil : RushHour::Client.find_by(:identifier => params_identifier).id
      })
    payload
  end

  def parse_user_agent(user_agent)
    ::UserAgent.parse(user_agent)
  end

  def parse_url(url)
    new_url = Hash.new
    if url[0..6] == "http://"
      url = url[7..-1]
    elsif url[0..7] == "https://"
      url = url[8..-1]
    end
    url = url.split("/")
    new_url[:root] = url.shift
    new_url[:path] = url.join("/")
    new_url
  end

  def params_parser(params)
    JSON.parse(params["payload"], {:symbolize_names => true})
  end

end
