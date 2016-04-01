module RushHour
  class PayloadCreator

    def create_url(root, path)
      Url.find_or_create_by({root: root, path: path})
    end

    def create_responded_in(responded_in)
      RespondedIn.find_or_create_by({:responded_in => responded_in})
    end

    def create_referred_by(root, path)
      ReferredBy.find_or_create_by({root: root, path: path})
    end

    def create_request_type(request_type)
      RequestType.find_or_create_by({:verb => request_type})
    end

    def create_event_name(event_name)
      EventName.find_or_create_by({:event_name => event_name})
    end

    def create_user_agent(os, browser)
      UserAgent.find_or_create_by({os: os, browser: browser})
    end

    def create_resolution(width, height)
      Resolution.find_or_create_by({width: width, height: height})
    end

    def create_ip(ip)
      Ip.find_or_create_by({:ip => ip})
    end

    def create_client(identifier, rootUrl)
      Client.find_or_create_by({identifier: identifier, rootUrl: rootUrl })
    end

    def create_payload(pr_params)
      params = params_parser(pr_params)
      params[:url] = parse_url(params[:url])
      PayloadRequest.new({
        # url_id => :root => params_parser(pr_params)[url].split[0]
        :url_id       => create_url(, "/search#{i + 1}").id,
        :requested_at => Date.new(:requested_at).to_s,
        :responded_in_id => create_responded_in(i + 1).id,
        :referred_by_id => create_referred_by("bing.com", "/search#{i + 1}").id,
        :request_type_id => create_request_type("GET").id,
        :event_name_id => create_event_name("eventName #{i + 1}").id,
        :user_agent_id => create_user_agent("OSX#{i + 1}", "Chrome #{i + 1}").id,
        :resolution_id => create_resolution("resolutionWidth #{i + 1}", "resolutionHeight #{i + 1}").id,
        :ip_id => create_ip("127.0.0.#{i + 1}").id,
        :client_id => create_client("jumpstartlab", "http://jumpstartlab.com").id
        })
    end

    def parse_url(url)
      if url[0..6] == "http://"
        url = url[7..-1]
      elsif url[0..7] == "https://"
        url = url[8..-1]
      end
      url = url.split("/")
      new_url[:root] =  url.shift
      new_url[:path] = url.join("/")
      new_url
    end

    def params_parser(params)
      parsed = JSON.parse(params[:payload], {:symbolize_names => true})
    end
  end
end
