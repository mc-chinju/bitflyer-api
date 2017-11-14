require "bitflyer_api/http/connection"
require "bitflyer_api/methods/public"
require "bitflyer_api/methods/private/account_statement"
require "bitflyer_api/methods/private/api"
require "bitflyer_api/methods/private/assets"
require "bitflyer_api/methods/private/trade"

module BitflyerApi
  class Client
    include BitflyerApi::Methods::Public
    include BitflyerApi::Methods::Private::AccountStatement
    include BitflyerApi::Methods::Private::API
    include BitflyerApi::Methods::Private::Assets
    include BitflyerApi::Methods::Private::Trade

    attr_accessor :conn

    def initialize(key, secret)
      @conn = BitflyerApi::HTTP::Connection.new(key, secret)
    end

    private
    def prepare_query(options)
      options.delete_if { |_, v| v.nil? }
    end
  end
end
