module Billymad
  module Operations
    module General
      def self.included(base) 
        base.send :include, Billymad::Operations::All
        base.send :include, Billymad::Operations::Find
        base.send :include, Billymad::Operations::Create
        base.send :include, Billymad::Operations::Update
        base.send :include, Billymad::Operations::Destroy
      end
    end
  end
end