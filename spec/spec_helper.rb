require "bundler/setup"
require "bitflyer_api"
require "pry"
require "vcr"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  VCR.configure do |c|
    c.cassette_library_dir = "spec/vcr"
    c.hook_into :webmock
    c.allow_http_connections_when_no_cassette = false
  end
end
