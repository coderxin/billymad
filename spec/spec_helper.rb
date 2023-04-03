require 'billymad'

Dir['./spec/support/**/*.rb'].sort.each { |f| require f }

FakeLogger = Struct.new(:input) do
  def info(message); end
end
