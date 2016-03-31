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
      # what to do about the rootUrl?
      client = Client.find_by(:identifier => identifier)
      if client.nil?
        status 403
        body "Application Not Registered"
      else
        "It's all good"
      end
    end
    not_found do
      erb :error
    end

  end
end
