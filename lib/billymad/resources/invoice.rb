module Billymad
  class Invoice < Resource::Base
    include Billymad::Operations::General
  
    mandatory_attributes_for :create, attributes: [ :client_id ]

    def complete
    end

    def pdf
    end

    def upload_signature(signature)
    end

    def email
    end

    def cancel
    end

    def uncancel
    end
  end
end