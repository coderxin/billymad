module Billymad
  module Operations
    module Create

      def self.included(base)
        base.extend(ClassMethods)
      end
   
      module ClassMethods
        def create(attributes)
          self.validate_attributes_for(:create, attributes)
          results = Billymad::Request::Proxy.post(self, params: attributes)
          prepare_results(results)
        end
      end
      
    end
  end
end