module Billymad
  class InvoiceComment < Resource::Base
    include Billymad::Operations::All
    include Billymad::Operations::Find
    include Billymad::Operations::Create
    include Billymad::Operations::Destroy

    mandatory_attributes_for :all,    attributes: [ :invoice_id ]
    mandatory_attributes_for :create, attributes: [ :invoice_id, :comment ]
  end
end