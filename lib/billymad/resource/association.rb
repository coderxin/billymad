module Billymad
  module Resource
    module Association
      def self.included(base)
        base.extend(ClassMethods)
      end

      def association_keys
        { resource_key => id }
      end

      module ClassMethods
        def association(name, options = {})
          define_association(name, options[:class_name])
        end

        private

        def define_association(association_name, target_class)
          define_method association_name do
            preloaded_data = fetch_associated_data(target_class)

            collection ||= CollectionProxy.new(preloaded_data)
            collection.associated_class ||= target_class
            collection.params           ||= association_keys
            collection
          end
        end
      end

      def fetch_associated_data(target_class)
        target_class.send(:all, association_keys)
      end
    end
  end
end

