module Empirical
  module Client
    module Endpoints
      class ActivitySession < Empirical::Client::Endpoint

        endpoint_name "activity_sessions"

        api_keys :percentage, :time_spent, :state, :completed_at, :activity_uid, :anonymous



        def as_json
          rv = {data: {}}

          self.class.api_keys.each { |x| rv[x] = self.send(x) }
          data_keys.map { |x| rv[:data][x] = self.send(x).to_yaml }
          return rv
        end


        private



        def other_thing
          @score.activity_uid = session[:uid]
          result = @score.save

          if @score.id.blank?
            data = @score.activity_session.data.except(*@score.class.special_attrs.dup)
            serialized_data = {}

            data.each do |key, value|
              serialized_data[key] = value.to_yaml
            end

            params = { data: serialized_data }

            @score.class.special_attrs.each do |attr|
              params[attr] = @score.send(attr)
            end

            result = @score.send(:api).post 'activity_sessions', params

            raise "#{params} - #{result.inspect}" if @score.id.blank?
          end
          session[:activity_session_id] = @score.id
        end


      end
    end
  end
end
