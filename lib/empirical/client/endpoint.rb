require 'hashie'

module Empirical
  module Client
    class Endpoint < ::Hashie::Mash

      attr_accessor :token, :client, :config, :api_base

      def initialize(options = {})
        super

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
          raise Empirical::Client::ApiException.new("API Connection Failed - #{e}")
        rescue Faraday::TimeoutError => e
          # api timed out
          @config.logger.info "API Timed Out - #{e}"
          raise Empirical::Client::ApiException.new("API Connection Timed Out - #{e}")
        end

        # process the response
        case result.status

        when 200..310

          self.merge!(result.body)

          if meta.status == 'success'
            return self
          else
            raise Empirical::Client::EndpointException.new("message: #{meta.message}")
          end

        when 404
            raise Empirical::Client::EndpointException.new("Missing Record")


        else
          raise Empirical::Client::ApiException.new("Missing response body or API failure")
        end

      end


      private
      def client
        @client ||= Faraday.new @api_base do |conn|
          conn.request :oauth2, @token
          conn.request :json

          conn.response :json, content_type: /\bjson$/
          conn.response :mashify

          conn.adapter :patron # Faraday.default_adapter
        end
      end
    end
  end
end

