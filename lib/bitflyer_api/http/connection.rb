require "bitflyer_api/http/middleware"
require "faraday"
require "faraday_middleware"

module BitflyerApi
  module HTTP
    class Connection
      extend Forwardable
      def_delegators :@conn, :get, :post

      def initialize(key, secret)
        @conn = Faraday.new(url: "https://api.bitflyer.jp") do |conn|
          conn.request :json
          conn.response :json
          conn.use BitflyerApi::HTTP::Middleware, key, secret
          conn.adapter Faraday.default_adapter
        end
      end
    end
  end
end
