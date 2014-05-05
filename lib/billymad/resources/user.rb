module Billymad
  class User < Base
    include Billymad::Operations::All
    include Billymad::Operations::Find

    def self.logged_in
      find('myself')
    end
  end
end