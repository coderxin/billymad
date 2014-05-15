module Billymad
  class User < Resource::Base
    include Billymad::Operations::All
    include Billymad::Operations::Find

    association :property_values, class_name: Billymad::UserPropertyValue

    def self.logged_in
      find('myself')
    end
  end
end