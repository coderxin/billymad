module Billymad
  module ArgumentValidations

    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
          
      def mandatory_attributes_for(method, options = {})
        @mandatory_attributes ||= {}
        @mandatory_attributes[method] = options.fetch(:attributes, [])
      end

      def validate_attributes_for(method, attributes)
        @mandatory_attributes ||= {}
        if attrs = @mandatory_attributes[method]
          attrs.each do |attribute|
            unless attributes.keys.map(&:to_sym).include?(attribute)
              raise Billymad::APIError.new("You must specify the mandatory parameter :#{attribute}")
            end
          end
        end
      end

    end
  end
end