module Billymad
  module Request
    class Base
      attr_reader :info

      def initialize(info)
        @info = info
      end

      def perform
        if response = Billymad::Request::Rest.call(info.method, info.url, info.parameters)
          handle_response(response)
        end
      end

    private

      def handle_response(response)
        if info.method == :delete
          response.code == 200
        else
          data = parse_response(response)
          extract_data(data, info.resource_name, info.plural_resource_name)
        end        
      end

      def parse_response(response)
        if response and !response.empty?
          JSON.parse(response) 
        end
      end

      def extract_data(data, resource_name, plural_resource_name)
        if data.has_key?(resource_name)
          data[resource_name]
        else data.has_key?(plural_resource_name)
          # TODO: wrap collection into object
          if data = data[plural_resource_name][resource_name]
            data.is_a?(Array) ? data : [ data ]
          else
            []            
          end
        end
      end

    end
  end
end