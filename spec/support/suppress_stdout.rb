# frozen_string_literal: true

# Suppress output to STDOUT during tests
RSpec.configure do |config|
  io = IO.sysopen('/dev/null', 'w+')
  dev_null = IO.new(io)
  config.before(:suite) do
    $stdout = dev_null
  end
  config.after(:suite) do
    $stdout = STDOUT
  end
end
