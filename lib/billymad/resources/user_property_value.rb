module Billymad
  class UserPropertyValue < Resource::Base
    include Billymad::Operations::General

    mandatory_attributes_for :all, attributes: [:user_id]
    mandatory_attributes_for :create, attributes: %i[user_id user_property_id value]
  end
end

