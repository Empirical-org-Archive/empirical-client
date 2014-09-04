module Empirical
  module Client
    class Endpoint

      attr_accessor :token, :client, :config, :api_base

      def initialize(options = {})
        @config = Empirical::Client.configuration
        @api_base = config.api_host + "/api/v1"
      end


      # gets a list of all items, paginate style
      def all(limit = 25, offset = 0)
        raise NotImplementedError
      end

      # finds an item for a single id
      def find(id, params = {})
        raise NotImplementedError
      end

      # creates an item
      def create(params)
        raise NotImplementedError
      end

      # updates an item
      def update(id, params)
        raise NotImplementedError
      end

      def request(verb, path, &block)
        begin
          result = client.send(verb, path) do
            yield if block_given?
          end
        rescue Faraday::ConnectionFailed => e
          # download failed
          @config.logger.info "API Connection Failed - #{e}"
          return false
        rescue Faraday::TimeoutError => e
          # api timed out
          @config.logger.info "API Timed Out - #{e}"
          return false
        end

        # process the response
        if result.status.between?(200, 310)
          return Hashie::Mash.new(response.body)
        else
          message = result.body['meta']['message'] rescue "none"
           errors = result.body['meta']['errors']  rescue []

          raise Empirical::Client::EndpointException.new(message)
        end

      end


      private
      def client
        @client ||= Faraday.new @api_base do |conn|
          conn.request :oauth2, @token
          conn.request :json

          conn.response :json, content_type: /\bjson$/
          conn.response :mashify

          conn.adapter Faraday.default_adapter
        end
      end
    end
  end
end

