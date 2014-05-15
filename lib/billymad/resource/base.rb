module Billymad
  module Resource
    class Base
      include Association
      extend Validations
      extend Utils

      def initialize(attributes = {})
        set_attributes(attributes)
        convert_attributes
      end

      def set_attributes(attributes)
        attributes.each_pair do |key, value|
          self.class.send(:attr_accessor, key)
          instance_variable_set("@#{key}", value)
        end
      end

      def convert_attributes
        @id      = id.to_i if @id
        @created = Time.parse(created) if @created
      end

      def prepare_results(response)
        self.class.prepare_results(response)
      end

      def attributes
        self.instance_variables.inject({}) do |hash, variable| 
          key = variable.to_s.gsub(/@/,"")
          hash[key.to_sym] = self.send(key)
          hash
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
          @resource_name ||= demodulize(self.name).dasherize
        end

        def plural_resource_name
          "#{resource_name}s"
        end

        def prepare_results(response)
          if response.is_a? Array
            response.inject([]) { |results, data| results << self.new(data) }
          else
            (response and !response.empty?) ? self.new(response) : nil
          end
        end

      end
    end
  end
end