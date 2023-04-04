module Billymad
  module Operations
    module Update
      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods
        def update(attributes)
          validate_attributes_for(:update, attributes)
          results = Billymad::Request::Proxy.put(self, id: attributes.delete(:id), params: attributes)
          prepare_results(results)
        end
      end

      def update(attributes)
        self.class.validate_attributes_for(:update, attributes)
        results = Billymad::Request::Proxy.put(self.class, id: id, params: attributes)
        self.class.prepare_results(results)
      end

      def reload!
        results = Billymad::Request::Proxy.get(self.class, id: id)
        set_attributes(results)
        self
      end
    end
  end
end

