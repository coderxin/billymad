require 'json'

module Billymad
  module Request
    class Info
      attr_reader :resource_name, :plural_resource_name, :method

      def initialize(resource, options = {})
        @resource_name = resource.resource_name
        @plural_resource_name = resource.plural_resource_name

        @resource_id = options[:id]
        @method = options[:method]
        @params = options.fetch(:params, {})
      end

      def url
        if single_record?
          "#{plural_resource_name}/#{resource_id}"
        else
          plural_resource_name
        end
      end

      def parameters
        if method == :get
          formatted_params
        elsif %i[post put].include?(method)
          post_and_put_params_format
        else
          {}
        end
      end

      private

      attr_reader :params, :resource_id

      def single_record?
        resource_id
      end

      def formatted_params
        params.empty? ? {} : { params: params }
      end

      def post_and_put_params_format
        { resource_name => params }.to_json
      end
    end
  end
end

