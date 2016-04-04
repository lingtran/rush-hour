require_relative "../models/payload_creator"

require_relative "../models/attribute_creator"

module RushHour

  class Server < Sinatra::Base
    include AttributeCreator

    get '/' do
      erb :home, :layout => :home
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
      end
    end

    post '/sources/:identifier/data' do |identifier|
      payload = PayloadCreator.new(params)
      status payload.status_code
      body payload.message
    end

    get '/sources/:identifier' do |id|
      client = Client.find_by(:identifier => id)
      if client.nil?
        erb :client_error, :locals => {:identifier => id}
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
          count_for_event = hours.values.reduce(:+)
          erb :event, :locals => {:identifier => id, :event_name => event, :hours => hours, :count_for_event => count_for_event }
        else
          erb :event_error, :locals => { :identifier => id, :event_name => event }
        end
      else
        erb :client_error, :locals => {:identifier => id}
      end
    end

    get '/sources/:identifier/events' do |id|
      client = Client.find_by(:identifier => id)
      if client
        client_events = client.event_names.pluck(:event_name).uniq
        erb :events_index, :locals => { :identifier => id, :client_events => client_events }
      else
        erb :error, :locals => { :identifier => id }
      end
    end

    not_found do
      erb :error, :locals => { :identifier => "nil" }
    end

  end
end
