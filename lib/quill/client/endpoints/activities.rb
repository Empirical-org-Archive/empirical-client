module Quill
  module Client
    module Endpoints
      class Activities < Quill::Client::Endpoint

        def find(id)
          # execute the request
          response = request(:get, "activities/#{id}")

          debugger

          # check for metadata
          if response.status == 'success'
            return response.activity
          else
          end
        end


      end
    end
  end
end
