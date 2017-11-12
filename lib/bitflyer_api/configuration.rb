module BitflyerApi
  module Configuration

    CONFIGURABLE_ATTRIBUTES = %i(key secret)
    attr_accessor *CONFIGURABLE_ATTRIBUTES

    def configure
      yield self
    end
  end
end
