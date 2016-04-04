require_relative "../models/payload_creator"

require_relative "../models/attribute_creator"

module RushHour

  class Server < Sinatra::Base
    include AttributeCreator

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
      payload = PayloadCreator.new(params)
      status payload.status_code
      body payload.message
    end

    get '/sources/:identifier' do |id|
      client = Client.find_by(:identifier => id)
      if client.nil?
        erb :client_error
      elsif client.payload_requests.nil?
        erb :payload_missing_error
      elsif client
        urls = client.urls.pluck(:root, :path).uniq
        erb :client, :locals => {:client => client, :identifier => id, :urls => urls }
      end
    end

    get '/sources/:identifier/urls/:relativepath' do |id, relpath|
      client = Client.find_by(:identifier => id)
      url = client.urls.find_by(:path => relpath)
      erb :client_url, :locals => { :client => client, :identifier => id, :relativepath => relpath, :url => url }
    end

    get '/sources/:identifier/events/:eventname' do |id, event|
      client = Client.find_by(:identifier => id)

      if client
        verified_event = EventName.find_by(:event_name => event)
        if verified_event
          hours = Hash.new(0)
          verified_event.payload_requests.map {|pr| pr.requested_at.hour }.reduce(0){ |sum, element| hours[element] += 1 }
          erb :event, :locals => { :event_name => event, :hours => hours }
        else
          redirect "/sources/#{id}/events"
        end
      else
        erb :client_error
      end
    end

    get '/sources/:identifier/events' do |id|
      client = Client.find_by(:identifier => id)
      events = client.event_names.pluck(:event_name)
      erb :event_error, :locals => { :identifier => id, :event_name => events }
    end

    not_found do
      erb :error
    end

  end
end
