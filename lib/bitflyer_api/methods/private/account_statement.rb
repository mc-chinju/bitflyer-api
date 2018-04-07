module BitflyerApi::Methods::Private
  module AccountStatement
    def my_addresses
      res = conn.get("/v1/me/getaddresses")
      res.body
    end

    def my_coin_ins(count: 100, before: nil, after: nil)
      query = prepare_query(
        count: count,
        before: before,
        after: after
      )

      res = conn.get("/v1/me/getcoinins", query)
      res.body
    end

    def my_coin_outs(count: 100, before: nil, after: nil)
      query = prepare_query(
        count: count,
        before: before,
        after: after
      )

      res = conn.get("/v1/me/getcoinouts", query)
      res.body
    end

    def my_bank_accounts(count: 100, before: nil, after: nil)
      query = prepare_query(
        count: count,
        before: before,
        after: after
      )

      res = conn.get("/v1/me/getbankaccounts", query)
      res.body
    end

    def my_deposits(count: 100, before: nil, after: nil)
      query = prepare_query(
        count: count,
        before: before,
        after: after
      )

      res = conn.get("/v1/me/getdeposits", query)
      res.body
    end

    def my_withdraw(currency_code: "JPY", bank_account_id:, amount:, code: nil)
      body = "{
        'currency_code': \"#{currency_code}\",
        'bank_account_id': \"#{bank_account_id}\",
        'amount': \"#{amount}\",
        'code': \"#{code}\",
      }"

      res = conn.post do |req|
        req.url "/v1/me/withdraw"
        req.body = body
      end

      res.body
    end

    def my_withdrawals(count: 100, before: nil, after: nil)
      query = prepare_query(
        count: count,
        before: before,
        after: after
      )

      res = conn.get("/v1/me/getwithdrawals", query)
      res.body
    end
  end
end
