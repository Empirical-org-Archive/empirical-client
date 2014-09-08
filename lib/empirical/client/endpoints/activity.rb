module Empirical
  module Client
    module Endpoints
      class Activity < Empirical::Client::Endpoint

        def find(id)
          # execute the request
          request(:get, "activities/#{id}")
        end


      end
    end
  end
end
