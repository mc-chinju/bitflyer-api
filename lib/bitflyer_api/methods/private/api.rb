module BitflyerApi::Methods::Private
  module API
    def my_permissions
      res = conn.get("/v1/me/getpermissions")
      res.body
    end
  end
end
