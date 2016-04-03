require_relative "../models/payload_creator"
module RushHour

  class Server < Sinatra::Base
    include PayloadCreator

    get '/' do
      erb :home, :layout => :home
      # erb :dashboard
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
        body "Shit's missing!"
      else
        client = Client.find_by(:identifier => params["identifier"])
        payload = create_payload(params)
        if client.nil?
          status 403
          body "Application Not Registered"
        elsif payload.nil?
          status 400
          body "Missing Payload"
        elsif !payload.save
          status 403
          body "Already Received Request"
        elsif payload.save
          status 200
          body "It's all good"
          redirect '/sources/#{identifier}'
        else
          status 418
          body "I'm a little teapot"
        end
      end
    end

    get '/sources/:identifier' do |id|
      client = Client.find_by(:identifier => id)
      if client.nil?
        erb :client_error
      elsif client.payload_requests.nil?
        erb :payload_missing_error
      elsif client
        erb :client, :locals => {:client => client, :identifier => id}
      end
    end

    get '/sources/:identifier/urls/:relativepath' do |id, relativepath|
      client = Client.find_by(:identifier => id)
      erb :client_url, :locals => { :client => client, :identifier => id, :relativepath => relativepath }
    end

    not_found do
        erb :error
    end

  end
end
