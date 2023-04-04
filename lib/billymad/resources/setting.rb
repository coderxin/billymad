module Billymad
  class Setting < Resource::Base
    include Billymad::Operations::All
    include Billymad::Operations::Update
  end
end

