module Billymad
  class ClientProperty < Base
    include Billymad::Operations::General

    mandatory_attributes_for :create, attributes: [ :name, :type ]

    def self.plural_resource_name
      'client-properties'
    end
  end
end