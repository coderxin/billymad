module Billymad
  module Operations
    module Find
      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods
        def find(resource_id)
          results = Billymad::Request::Proxy.get(self, id: resource_id)
          prepare_results(results)
        end
      end
    end
  end
end

