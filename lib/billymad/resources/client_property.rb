module Billymad
  class ClientProperty < Resource::Base
    include Billymad::Operations::General

    mandatory_attributes_for :create, attributes: %i[name type]

    def self.plural_resource_name
      'client-properties'
    end
  end
end

