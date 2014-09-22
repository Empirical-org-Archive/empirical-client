module Empirical
  module Client
    module Endpoints
      class Activity < Empirical::Client::Endpoint

        endpoint_name "activities"

        api_keys :name, :description, :activity_classification_id, :topic_id, :flags

      end
    end
  end
end
