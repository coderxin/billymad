module Billymad
  class Contact < Resource::Base
    include Billymad::Operations::General

    mandatory_attributes_for :all, attributes: [ :client_id ]
  end
end