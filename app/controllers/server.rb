require_relative "../models/payload_creator"
module RushHour

  class Server < Sinatra::Base
    include PayloadCreator

    get '/' do
      # erb :home, :layout => :home
      erb :dashboard
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
      if params.nil?
        status 400
        body "#{client.errors.full_messages.join(", ")}"
      else
        client = Client.find_by(:identifier => params["identifier"])
        payload = create_payload(params)
        if client.nil?
          status 403
          body "Application Not Registered"
        elsif payload.nil?
          status 400
          body "#{client.errors.full_messages.join(", ")}"
        elsif payload.save
          status 200
          body "It's all good"
        elsif payload.persisted?
          status 403
          body "Already Received Request"
        else
          status 420
          body "Shit's fucked"
        end
      end
    end

    not_found do
      erb :error
    end

  end
end
