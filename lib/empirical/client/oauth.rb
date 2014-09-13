module Empirical
  module Client

    class Oauth < ::OAuth2::Client

      def initialize(client_id=nil, client_secret=nil, opts={}, &block)
        config = Empirical::Client.configuration

        id = client_id || config.client_id
        secret = client_secret || config.client_secret
        opts.reverse_merge!(site: config.api_host)

        super(id, secret, opts, &block)
      end
    end

  end
end
