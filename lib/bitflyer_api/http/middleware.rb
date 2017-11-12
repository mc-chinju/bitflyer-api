require "faraday"
require "openssl"

module BitflyerApi
  module HTTP
    class Middleware < Faraday::Middleware
      attr_accessor :key, :secret

      def initialize(app, key, secret)
        super(app)
        @key = key
        @secret = secret
      end

      def call(env)
        return @app.call(env) if key.nil? || secret.nil?

        env[:request_headers]["ACCESS-KEY"] = key if key
        env[:request_headers]["ACCESS-TIMESTAMP"] = timestamp
        env[:request_headers]["ACCESS-SIGN"] = signature(env, secret)
        @app.call env
      end

      private

      def signature(env, secret)
        method = env[:method].to_s.upcase
        query = env[:url].query.present? ? "?" + env[:url].query : ""
        path = env[:url].path + query
        body = env[:body] || ""

        OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new("sha256"), secret, "#{timestamp}#{method}#{path}#{body}")
      end

      def timestamp
        Time.now.to_i.to_s
      end
    end
  end
end
