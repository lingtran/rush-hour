require 'digest/sha1'
require 'json'
require_relative '../models/attribute_creator'
module RushHour
  class PayloadCreator
    include AttributeCreator
    attr_reader :status_code, :message
    def initialize(params)
      final_params = create_payload(params)
      @status_code = final_params[0]
      @message = final_params[1]
    end


    def create_payload(params)
      client = Client.find_by(identifier: params["identifier"])
      return missing_client(params["identifier"]) unless client

      raw_payload = JSON.parse(params["payload"])
      payload = make_payload(raw_payload, client)
      request = PayloadRequest.new(payload)

      get_response(request, payload, client)
    end

    def get_response(request, payload, client)
      if PayloadRequest.exists?(digest: payload["digest"])
        [403, "#{client.identifier.capitalize}: this request already exists."]
      elsif request.save
        [200, "It's all good"]
      elsif payload.values.include?(nil)
        [400, request.errors.full_messages.join("")]
      else
        [420, "Shit's broke!"]
      end
    end

    def make_payload(raw_payload, client)
      new_url = parse_url(raw_payload["url"])
      new_referred_by = parse_url(raw_payload["referredBy"])
      new_user_agent = parse_user_agent(raw_payload["userAgent"])
      payload = {
        "requested_at" => raw_payload["requestedAt"],
        "ip_id" => create_ip(raw_payload["ip"]).id,
        "responded_in" => raw_payload["respondedIn"],
        "referred_by_id" => create_referred_by(new_referred_by[:root], new_referred_by[:path]).id,
        "url_id" => create_url(new_url[:root], new_url[:path]).id,
        "request_type_id" => create_request_type(raw_payload["requestType"]).id,
        "event_name_id" => create_event_name(raw_payload["eventName"]).id,
        "user_agent_id" => create_user_agent(new_user_agent.platform, new_user_agent.browser).id,
        "resolution_id" => create_resolution(raw_payload["resolutionWidth"], raw_payload["resolutionHeight"]).id,
        "client_id" => client.id,
        "digest" => Digest::SHA1.hexdigest(raw_payload.to_s)
      }
      payload
    end

    def parse_user_agent(user_agent)
      ::UserAgent.parse(user_agent)
    end

    def parse_url(url)
      new_url = Hash.new
      if url[0..6] == "http://"
        url = url[7..-1]
      elsif url[0..7] == "https://"
        url = url[8..-1]
      end
      url = url.split("/")
      new_url[:root] = url.shift
      new_url[:path] = url.join("/")
      new_url
    end

    def missing_client(params)
      [403, "Client #{params} does not exist."]
    end

  end
end
