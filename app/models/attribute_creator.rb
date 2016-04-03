module AttributeCreator

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

end
