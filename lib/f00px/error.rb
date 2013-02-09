module F00px
  class Error < StandardError

    class << self

      def register_error(error)
        @errors ||= {}
        @errors[error::STATUS_CODE] = error
      end

      def from_response(response)
        klass = @errors[response.status] || self
        klass.new(parse_error(response.body))
      end

      def parse_error(body)
        return body if body.is_a? String
        if body.nil?
          ''
        elsif body[:error]
          body[:error]
        elsif body[:errors]
          first = Array(body[:errors]).first
          if first.is_a?(Hash)
            first[:message].chomp
          else
            first.chomp
          end
        end
      end
    end
  end
end

require 'f00px/error/forbidden'
require 'f00px/error/unauthorized'
