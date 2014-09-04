module Empirical
  class Client
    module Transport

      attr_accessor :token, :client, :config

      def initialize(options = {})
        @config = Configuration.new(options, api_url: 'http://api.quill.org/')
      end


      # http verb methods
      def get(path, params = {})
        request(:get, path, {params: params})
      end

      def post(path, params = {})
        request(:post, path, {body: params})
      end

      def put(path, params = {})
        request(:put, path, {body: params})
      end


      private

      def token
        @token ||= OAuth2::AccessToken.new(client, config.access_token)
      end

      def client
        @client ||= OAuth2::Client.new(config.client_id, config.client_secret, site: config.api_url, raise_errors: false) do |conn|
          conn.request :json
          conn.response :json
          conn.adapter Faraday.default_adapter
        end
      end

      def request(verb, path, params)
        response = token.request(verb, path, params)

        if response.status.between?(400, 600)
          raise response.error
        end

        response
      end
    end
  end
end

