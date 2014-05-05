module Billymad
  module Operations
    module All

      def self.included(base)
        base.extend(ClassMethods)
      end
   
      module ClassMethods
        def all(attributes = {})
          self.validate_attributes_for(:all, attributes)
          results = Billymad::Request::Proxy.get(self, params: attributes)
          prepare_results(results)
        end
      end

    end
  end
end