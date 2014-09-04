module Empirical
  module Client

    class Oauth < OAuth2::Client

      def initialize(client_id=nil, client_secret=nil, opts={}, &block)
        config = Configuration.new({}, site_url: 'http://www.quill.org/')

        id = client_id || config.client_id
        secret = client_secret || config.client_secret
        opts.reverse_merge!(site: config.site_url)

        super(id, secret, opts, &block)
      end
    end

  end
end
