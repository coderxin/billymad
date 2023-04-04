module Billymad
  class Unit < Resource::Base
    include Billymad::Operations::General

    mandatory_attributes_for :create, attributes: [:name]
  end
end

