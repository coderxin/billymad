module Billymad
  class InvoiceTag < Resource::Base
    include Billymad::Operations::All
    include Billymad::Operations::Find
    include Billymad::Operations::Create
    include Billymad::Operations::Destroy

    mandatory_attributes_for :create, attributes: [ :invoice_id, :name ]
  end
end