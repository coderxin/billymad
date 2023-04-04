module Billymad
  module Operations
    module Destroy
      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods
        def destroy(resource_id)
          Billymad::Request::Proxy.delete(self, resource_id)
        end
      end

      def destroy
        Billymad::Request::Proxy.delete(self.class, id)
      end
    end
  end
end

