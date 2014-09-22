module Empirical
  module Client
    module Endpoints
      class ActivitySession < Empirical::Client::Endpoint

        endpoint_name "activity_sessions"

        api_keys :percentage, :time_spent, :state, :completed_at, :activity_uid, :anonymous

      end
    end
  end
end
