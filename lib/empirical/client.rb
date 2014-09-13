require 'oauth2'
require 'faraday'
require 'faraday_middleware'

begin
  require 'byebug'
rescue LoadError
  # lazy for development
end

require "empirical/client/version"
require "empirical/client/exceptions"
require "empirical/client/configuration"
require "empirical/client/oauth"
require "empirical/client/endpoint"
require "empirical/client/endpoints/activity"
require "empirical/client/endpoints/activity_session"

module Empirical
  module Client
  end
end
