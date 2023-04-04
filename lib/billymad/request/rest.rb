require 'rest-client'

module Billymad
  module Request
    class Rest
      EXCEPTIONS = [
        RestClient::ResourceNotFound,
        RestClient::Unauthorized,
        RestClient::Forbidden
      ].freeze

      class << self
        def call(method, url, params)
          api[url].send(method, params)
        rescue *EXCEPTIONS => e
          log(e, method, url, params)
          nil
        end

        private

        def auth_headers
          {
            'Accept' => content_type,
            'Content-Type' => content_type,
            'X-BillomatApiKey' => config.api_key
          }
        end

        def content_type
          "application/#{config.api_format}"
        end

        def api
          @api ||= RestClient::Resource.new(config.api_url, headers: auth_headers)
        end

        def config
          @config ||= Billymad.configuration
        end

        def log(exception, method, url, params)
          config.logger.info("[#{method}] Resource: #{url} Params: #{params} Error: #{exception.message}")
        end
      end
    end
  end
end

