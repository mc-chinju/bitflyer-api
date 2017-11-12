require "bitflyer_api/http/connection"

module BitflyerApi
  class Client
    attr_accessor :conn

    def initialize(key, secret)
      @conn = BitflyerApi::HTTP::Connection.new(key, secret)
    end
  end
end
