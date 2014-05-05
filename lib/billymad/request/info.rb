module Billymad
  module Request
    class Info
      attr_reader :method, :resource_name, :plural_resource_name

      def initialize(resource, options = {})
        @resource_name        = resource.resource_name
        @plural_resource_name = resource.plural_resource_name
        
        @resource_id = options[:id]
        @method      = options[:method]
        @parameters  = options.fetch(:params, {})
      end

      def url
        if single_record?
          "#{@plural_resource_name}/#{@resource_id}"
        else
          @plural_resource_name
        end
      end

      def parameters
        if @method == :get
          get_params_format
        elsif [:post, :put].include?(@method)
          post_and_put_params_format
        else 
          {}
        end
      end

    private

      def single_record?
        @resource_id
      end

      def get_params_format
        @parameters.empty? ? {} : { params: @parameters }
      end

      def post_and_put_params_format
        { @resource_name => @parameters }.to_json
      end

    end
  end
end