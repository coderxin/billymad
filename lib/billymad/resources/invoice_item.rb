module Billymad
  class InvoiceItem < Resource::Base
    include Billymad::Operations::General

    mandatory_attributes_for :all, attributes: [:invoice_id]
    mandatory_attributes_for :create, attributes: [:invoice_id]
  end
end

