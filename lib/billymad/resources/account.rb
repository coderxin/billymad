module Billymad
  class Account < Base
    def self.current
      response = Billymad::Request::Proxy.get(self, id: 'myself')
      prepare_results(response)
    end

  private

    # Since there is no resource named "Account"
    # we have to override it explicitly 
    def self.resource_name
      'client'
    end
  end
end