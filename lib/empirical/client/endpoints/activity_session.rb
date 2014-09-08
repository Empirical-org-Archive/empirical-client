module Empirical
  module Client
    module Endpoints
      class ActivitySession < Empirical::Client::Endpoint

        def find(id)
          # execute the request
          request(:get, "activity_sessions/#{id}")
        end


      end
    end
  end
end
