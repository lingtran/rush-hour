module RushHour
  class Server < Sinatra::Base

    get '/' do
      'hello, world!'
    end

    post '/sources' do
      if params[:identifier].nil? || params[:rootUrl].nil?
        client = Client.new(params)
        client.save
        status 400
        body "#{client.errors.full_messages.join(", ")}"
      elsif Client.find_by(:identifier => params[:identifier])
        status 403
        body "Forbidden"
      else
        Client.create(:identifier => params[:identifier], :rootUrl => params[:rootUrl])
        status 200
        body "Client created"

      end
    end

    not_found do
      erb :error
    end
  end
end
