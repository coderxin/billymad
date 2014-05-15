require "delegate"

module Billymad
  module Resource
    class CollectionProxy < DelegateClass(Array)
      attr_accessor :associated_class, :params
      
      def initialize(array = []) 
        super(array)
      end  
      
      def all(attributes = {})
        associated_class.all(attributes.merge(params))
      end  

      def create(attributes = {})
        associated_class.create(attributes.merge(params))
      end

    end
  end
end