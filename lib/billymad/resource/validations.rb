module Billymad
  module Resource
    module Validations
      def mandatory_attributes_for(method, options = {})
        mandatory_attributes[method] = options.fetch(:attributes, [])
      end

      def validate_attributes_for(method, attributes)
        (mandatory_attributes[method] || []).each do |mandatory_attribute|
          raise_exception(mandatory_attribute) unless valid?(attributes, mandatory_attribute)
        end
      end

      private

      def valid?(attributes, attribute)
        attributes.keys.map(&:to_sym).include?(attribute)
      end

      def mandatory_attributes
        @mandatory_attributes ||= {}
      end

      def raise_exception(attribute)
        raise Billymad::APIError, "You must specify the mandatory parameter :#{attribute}"
      end
    end
  end
end

