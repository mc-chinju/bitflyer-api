module BitflyerApi::Methods::Private
  module Assets
    def my_balance
      res = conn.get("/v1/me/getbalance")
      res.body
    end

    def my_collateral
      res = conn.get("/v1/me/getcollateral")
      res.body
    end

    def my_collateral_accounts
      res = conn.get("/v1/me/getcollateralaccounts")
      res.body
    end
  end
end
