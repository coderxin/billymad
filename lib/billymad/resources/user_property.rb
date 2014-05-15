module Billymad
  class UserProperty < Resource::Base
    include Billymad::Operations::General

    mandatory_attributes_for :create, attributes: [ :name, :type ]

    def self.plural_resource_name
      'user-properties'
    end
  end
end