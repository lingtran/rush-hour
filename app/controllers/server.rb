module RushHour
  class Server < Sinatra::Base

    get '/' do
      'hello, world!'
    end

    post '/sources' do
      client = Client.new(params)
      if client.save
        status 200
        body "Client created"
      elsif Client.find_by(:identifier => params[:identifier])
        status 403
        body "Forbidden!"
      else
        status 400
        body "#{client.errors.full_messages.join(", ")}"
        # how do we access error messages for this case? is current one descriptive enough?
      end
    end

    post '/sources/:identifier/data' do |identifier|

      # status_code, body_content = ProcessPayload.call(identifier, params)
      # process_payload = ProcessPayload.call(identifier, params)
      # status(process_payload.status_code)
      # body(process_payload.body_content)
      # what to do about the rootUrl?
      client = Client.find_by(:identifier => identifier)
      parsed_params = JSON.parse(params[:payload])
      pr_creator(parsed_params)

      binding.pry
      payload = PayloadRequest.new(parsed_params)
      if client.nil?
        status 403
        body "Application Not Registered"
      elsif payload.save
        status 200
        body "It's all good"
      elsif payload.nil?
        status 400
        body "#{client.errors.full_messages.join(", ")}"
      end
    end

    def pr_creator(parsed_params)
      {
        :url_id =>
        :request_id => parsed_params[:requestedAt],
        :responded_in_id => parsed_params[:respondedIn],
        :referred_by_id => parsed_params[:referredBy],
        :request_type_id => parsed_params[:requstType],
        :event_name_id => parsed_params[:eventName],
        :user_agent_id => parsed_params[:userAgent],
        :resolution_id => { width: parsed_params[:resolutionWidth], height: parsed_params[:resolutionHeight] },
        :ip_id => parsed_params[:ip],
        :client_id => { :identifier => parsed_params[:identifier], :rootUrl => parsed_params[:rootUrl]}
      }
    end

    not_found do
      erb :error
    end

  end
end
