module Billymad
  class ClientPropertyValue < Resource::Base
    include Billymad::Operations::General

    mandatory_attributes_for :create, attributes: %i[client_id client_property_id value]
  end
end

