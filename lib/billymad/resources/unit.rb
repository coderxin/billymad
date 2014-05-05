module Billymad
  class Unit < Base
    include Billymad::Operations::General

    mandatory_attributes_for :create, attributes: [ :name ]
  end
end