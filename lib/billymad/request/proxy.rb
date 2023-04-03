module Billymad
  module Request
    class Proxy
      class << self
        def get(resource, options = {})
          info = Billymad::Request::Info.new(resource, **options.merge(method: :get))
          Billymad::Request::Base.new(info).perform
        end

        def post(resource, options = {})
          info = Billymad::Request::Info.new(resource, **options.merge(method: :post))
          Billymad::Request::Base.new(info).perform
        end

        def put(resource, options = {})
          info = Billymad::Request::Info.new(resource, **options.merge(method: :put))
          Billymad::Request::Base.new(info).perform
        end

        def delete(resource, record_id)
          info = Billymad::Request::Info.new(resource, id: record_id, method: :delete)
          Billymad::Request::Base.new(info).perform
        end
      end
    end
  end
end

