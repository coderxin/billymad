require "spec_helper"

describe Billymad do
  it { should be_const_defined(:Error) }
  it { should be_const_defined(:ConfigurationError) }
  it { should be_const_defined(:AuthenticationError) }
  it { should be_const_defined(:APIError) }
end 