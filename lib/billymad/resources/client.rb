module Billymad
  class Client < Resource::Base
    include Billymad::Operations::General

    association :properties, class_name: Billymad::ClientProperty
    association :property_values, class_name: Billymad::ClientPropertyValue
    association :tags, class_name: Billymad::ClientTag
    association :contacts, class_name: Billymad::Contact
  end
end