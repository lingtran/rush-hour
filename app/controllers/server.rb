require_relative "../models/payload_creator"
module RushHour

  class Server < Sinatra::Base
    include PayloadCreator

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
      client = Client.find_by(:identifier => params["identifier"])
      payload = create_payload(params["payload"], params["identifier"])
      if client.nil?
        status 403
        body "Application Not Registered"
      elsif payload.valid? && payload.save
        status 200
        body "It's all good"
      elsif payload.valid? && !payload.nil?
        status 403
        body "Already Received Request"
      elsif payload.nil?
        status 400
        body "#{client.errors.full_messages.join(", ")}"
      end
    end

    not_found do
      erb :error
    end

  end
end
