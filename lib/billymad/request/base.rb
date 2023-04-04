require 'json'

module Billymad
  module Request
    class Base
      HTTP_OK = 200

      attr_reader :info

      def initialize(info)
        @info = info
      end

      def perform
        return unless (response = Billymad::Request::Rest.call(info.method, info.url, info.parameters))

        handle_response(response)
      end

      private

      def handle_response(response)
        if info.method == :delete
          response.code == HTTP_OK
        else
          data = parse_response(response)
          extract_data(data, info.resource_name, info.plural_resource_name)
        end
      end

      def parse_response(response)
        return unless response && !response.empty?

        JSON.parse(response)
      end

      def extract_data(data, resource_name, plural_resource_name)
        if data.key?(resource_name)
          data[resource_name]
        elsif data.key?(plural_resource_name)
          # TODO: wrap collection into object
          if (data = data[plural_resource_name][resource_name])
            data.is_a?(Array) ? data : [data]
          else
            []
          end
        end
      end
    end
  end
end

