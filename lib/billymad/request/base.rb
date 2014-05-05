require "rest-client"

module Billymad
  module Request
    class Base
      attr_reader :info

      REST_EXCEPTIONS = [ RestClient::ResourceNotFound, RestClient::Unauthorized, RestClient::Forbidden ]

      def initialize(info)
        @info = info
      end

      def perform
        response = call_api
        if response
          if info.method == :delete
            response.code == 200
          else
            extract_data(parse_response(response))
          end
        else
          nil
        end
      end

      def parse_response(response)
        JSON.parse(response) if response and !response.empty?
      end

      def extract_data(data)
        if data.has_key?(info.resource_name)
          data[info.resource_name]
        else data.has_key?(info.plural_resource_name)
          # TODO: wrap collection into object
          if data = data[info.plural_resource_name][info.resource_name]
            data.is_a?(Array) ? data : [ data ]
          else
            []            
          end
        end
      end

      def call_api
        begin
          api[info.url].send(info.method, info.parameters)
        rescue *REST_EXCEPTIONS => e
          log(e)
          nil
        end
      end

    private

      def config
        @config ||= Billymad.configuration
      end

      def api
        @api ||= RestClient::Resource.new(config.api_url, headers: headers)
      end

      def headers
        {
          'Accept'           => content_type,
          'Content-Type'     => content_type,
          'X-BillomatApiKey' => config.api_key
        }
      end

      def content_type
        "application/#{config.api_format}"
      end

      def log(exception)
        message = "[#{info.method}] Resource: #{info.url} Params: #{info.parameters} Error: #{exception.message}"
        config.logger.info(message)
      end

    end
  end
end