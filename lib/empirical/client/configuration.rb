module Empirical
  module Client

    class << self
      attr_accessor :configuration

      def configuration
        @configuration ||= Configuration.new
      end

      def configure
        yield(configuration)
      end
    end


    class Configuration
      attr_accessor :api_host, :client_secret, :client_id, :access_token, :logger

      def initialize
             @api_host = ENV.fetch('QUILL_MAIN_APP_URL', '')
            @client_id = ENV.fetch('QUILL_CLIENT_ID', '')
        @client_secret = ENV.fetch('QUILL_CLIENT_SECRET', '')
      end

      def logger
        @loggger ||= Logger.new(STDOUT)
      end
    end

  end
end
