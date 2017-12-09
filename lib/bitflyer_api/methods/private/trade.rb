module BitflyerApi::Methods::Private
  module Trade
    def my_send_child_order(product_code:, child_order_type:, side:, price: nil, size:,
      minute_to_expire: 43200, time_in_force: "GTC")

      body = prepare_query(
        product_code: product_code,
        child_order_type: child_order_type,
        side: side,
        price: price,
        size: size,
        minute_to_expire: minute_to_expire,
        time_in_force: time_in_force,
      )

      res = conn.post do |req|
        req.url "/v1/me/sendchildorder"
        req.body = body
      end

      res.body
    end

    # TODO: merge child_order_id and child_order_acceptance_id
    def my_cancel_child_order(product_code:, child_order_id: nil, child_order_acceptance_id: nil)
      return unless child_order_id || child_order_acceptance_id

      body =
        if child_order_id
          prepare_query(
            product_code: product_code,
            child_order_id: child_order_id,
          )
        elsif child_order_acceptance_id
          prepare_query(
            product_code: product_code,
            child_order_acceptance_id: child_order_acceptance_id,
          )
        end

      res = conn.post do |req|
        req.url "/v1/me/cancelchildorder"
        req.body = body
      end

      res.body
    end

    def my_cancel_all_child_orders(product_code:)
      body = prepare_query(product_code: product_code)

      res = conn.post do |req|
        req.url "/v1/me/cancelallchildorders"
        req.body = body
      end

      res.body
    end

    def my_child_orders(product_code:, count: 100, before: nil, after: nil, child_order_state: nil, child_order_id: nil, child_order_acceptance_id: nil, parent_order_id: nil)
      query = prepare_query(
        product_code: product_code,
        count: count,
        before: before,
        after: after,
        child_order_state: child_order_state,
        child_order_id: child_order_id,
        child_order_acceptance_id: child_order_acceptance_id,
        parent_order_id: parent_order_id
      )

      res = conn.get("/v1/me/getchildorders", query)
      res.body
    end

    def my_send_ifd_order
    end

    def my_send_oco_order
    end

    def my_send_ifdoco_order
    end

    def my_send_parent_order(
      order_method: "SIMPLE",
      minute_to_expire: 43200,
      time_in_force: "GTC",
      product_code:,
      first_condition_type:,
      second_condition_type:,
      third_condition_type: nil,
      first_side:,
      second_side:,
      third_side: nil,
      size:,
      first_price: nil,
      second_price: nil,
      third_price: nil,
      first_trigger_price: nil,
      second_trigger_price: nil,
      third_trigger_price: nil,
      offset: nil
    )

      body =
        case order_method
        when "IFD"
          "{
             'order_method': \"#{order_method}\",
             'minute_to_expire': #{minute_to_expire},
             'time_in_force': \"#{time_in_force}\",
             'parameters': [{
               'product_code': \"#{product_code}\",
               'condition_type': \"#{first_condition_type}\",
               'side': \"#{first_side}\",
               'price': #{first_price},
               'trigger_price': #{first_trigger_price},
               'size': #{size}
             },
             {
               'product_code': \"#{product_code}\",
               'condition_type': \"#{second_condition_type}\",
               'side': \"#{second_side}\",
               'price': #{second_price},
               'trigger_price': #{second_trigger_price},
               'size': #{size}
             }]
           }"
        when "OCO"
          "{
             'order_method': \"#{order_method}\",
             'minute_to_expire': #{minute_to_expire},
             'time_in_force': \"#{time_in_force}\",
             'parameters': [{
               'product_code': \"#{product_code}\",
               'condition_type': \"#{first_condition_type}\",
               'side': \"#{first_side}\",
               'price': #{first_price},
               'trigger_price': #{first_trigger_price},
               'size': #{size}
             },
             {
               'product_code': \"#{order_method}\",
               'condition_type': \"#{second_condition_type}\",
               'side': \"#{second_side}\",
               'price': #{second_price},
               'trigger_price': #{second_trigger_price},
               'size': #{size}
             }]
           }"
        when "IFDOCO"
          "{
            'order_method': \'#{order_method}\',
            'minute_to_expire': #{minute_to_expire},
            'time_in_force': \"#{time_in_force}\",
            'parameters': [{
              'product_code': \"#{product_code}\",
              'condition_type': \"#{first_condition_type}\",
              'side': \"#{first_side}\",
              'price': #{first_price},
              'trigger_price': #{first_trigger_price},
              'size': #{size}
            },
            {
              'product_code': \"#{product_code}\",
              'condition_type': \"#{second_condition_type}\",
              'side': \"#{second_side}\",
              'price': #{second_price},
              'trigger_price': #{second_trigger_price},
              'size': #{size}
            },
            {
              'product_code': \"#{product_code}\",
              'condition_type': \"#{third_condition_type}\",
              'side': \"#{third_side}\",
              'price': #{third_price},
              'trigger_price': #{third_trigger_price},
              'size': #{size}
            }]
          }"

        else # SIMPLE
        end

      res = conn.post do |req|
        req.url "/v1/me/sendparentorder"
        req.body = body
      end

      res.body
    end

    def my_parent_orders(product_code:, count: 100, before: nil, after: nil, parent_order_state: nil)
      query = prepare_query(
        product_code: product_code,
        count: count,
        before: before,
        after: after,
        parent_order_state: parent_order_state,
      )

      res = conn.get("/v1/me/getparentorders", query)
      res.body
    end

    def my_parent_order(parent_order_id: nil, parent_order_acceptance_id: nil)
      return unless parent_order_id || parent_order_acceptance_id

      query =
        if parent_order_id
          prepare_query(parent_order_id: parent_order_id)
        else
          prepare_query(parent_order_acceptance_id: parent_order_acceptance_id)
        end

      res = conn.get("/v1/me/getparentorder", query)
      res.body
    end

    def my_cancel_parent_order(product_code:, parent_order_id: nil, parent_order_acceptance_id: nil)
      return unless parent_order_id || parent_order_acceptance_id

      body =
        if parent_order_id
          prepare_query(
            product_code: product_code,
            parent_order_id: parent_order_id,
          )
        else
          prepare_query(
            product_code: product_code,
            parent_order_acceptance_id: parent_order_acceptance_id,
          )
        end

      res = conn.post do |req|
        req.url "/v1/me/cancelparentorder"
        req.body = body
      end

      res.body
    end

    def my_executions(product_code:, count: 100, before: nil, after: nil, child_order_id: nil, child_order_acceptance_id: nil)
      query = prepare_query(
        product_code: product_code,
        count: count,
        before: before,
        after: after,
        child_order_id: child_order_id,
        child_order_acceptance_id: child_order_acceptance_id
      )

      res = conn.get("/v1/me/getexecutions", query)
      res.body
    end

    def my_positions(product_code:)
      query = prepare_query(product_code: product_code)

      res = conn.get("/v1/me/getpositions", query)
      res.body
    end

    def my_collateral_history(count: 100, before: nil, after: nil)
      query = prepare_query(
        count: count,
        before: before,
        after: after
      )

      res = conn.get("/v1/me/getcollateralhistory", query)
      res.body
    end

    def my_trading_commission(product_code:)
      query = prepare_query(product_code: product_code)

      res = conn.get("/v1/me/gettradingcommission", query)
      res.body
    end
  end
end
