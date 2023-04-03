module Billymad
  module Resource
    class Base
      include Association
      include Utils
      extend Validations

      def initialize(attributes = {})
        set_attributes(attributes)
        convert_attributes
      end

      def set_attributes(attributes)
        attributes.each_pair do |key, value|
          sanitized_key = underscore(key)
          self.class.send(:attr_accessor, sanitized_key)
          instance_variable_set("@#{sanitized_key}", value)
        end
      end

      def convert_attributes
        @id = id.to_i if @id
        @created = Time.parse(created) if @created
      end

      def prepare_results(response)
        self.class.prepare_results(response)
      end

      def attributes
        instance_variables.each_with_object({}) do |variable, hash|
          key = variable.to_s.gsub(/@/, '')
          hash[key.to_sym] = send(key)
        end
      end

      private

      def resource_name
        @resource_name ||= self.class.resource_name
      end

      def resource_key
        "#{resource_name}_id"
      end

      class << self
        def resource_name
          @resource_name ||= demodulize(name).dasherize
        end

        def plural_resource_name
          "#{resource_name}s"
        end

        def prepare_results(response)
          if response.is_a? Array
            response.inject([]) { |results, data| results << new(data) }
          else
            response && !response.empty? ? new(response) : nil
          end
        end
      end
    end
  end
end

