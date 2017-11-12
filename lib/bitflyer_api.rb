require "bitflyer_api/version"
require "bitflyer_api/configuration"
require "bitflyer_api/client"
require "active_support"
require "active_support/core_ext"

module BitflyerApi
  extend BitflyerApi::Configuration

  def self.client
    BitflyerApi::Client.new(key, secret)
  end
end
