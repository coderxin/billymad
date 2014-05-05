module Billymad
  class Setting < Base
    include Billymad::Operations::All
    include Billymad::Operations::Update
  end
end