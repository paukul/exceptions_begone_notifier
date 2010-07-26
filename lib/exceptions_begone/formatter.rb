module ExceptionsBegone
  class Formatter
    class << self
      def format_data(category, notification)
        notification.symbolize_keys!
        notification.merge!(:category => category)
        serialized_notification = serialize_data(notification)
        to_json(serialized_notification)
      end

      def format_exception_data(exception, controller, request)
        _file, _line, _method = (exception.backtrace[0].scan /^([^:]+):(\d+)(?::in `([^']+)')?$/)[0]
        { :identifier => generate_identifier(controller, exception, _method),
          :payload => {
            :file => _file,
            :line => _line,
            :method => _method,
            :message => "#{exception.class}: #{exception.message}",
            :action => controller.action_name,
            :controller => controller.controller_name,
            :parameters => request.parameters,
            :url => request.url,
            :ip => request.ip,
            :request_environment => request.env,
            :session => request.session,
            :environment => ENV.to_hash,
            :backtrace => exception.backtrace
          }
        }
      end

      def generate_identifier(controller, exception, method)
        "#{controller.controller_name}#{controller.action_name}#{method}#{exception.class}"
      end

      def serialize_data(data)
        case data
        when String
          data
        when Hash
          data.inject({}) do |result, (key, value)|
            result.update(key => serialize_data(value))
          end
        when Array
          data.map do |elem|
            serialize_data(elem)
          end
        else
          data.to_s
        end
      end

      def to_json(attributes)
        ActiveSupport::JSON.encode(:notification => attributes)
      end
    end
  end
end
