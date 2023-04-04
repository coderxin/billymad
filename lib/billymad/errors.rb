module Billymad
  class Error < StandardError; end
  class ConfigurationError < Error; end
  class APIError < Error; end
  class AuthenticationError < Error; end
end

