module BitflyerApi::Methods::Private
  module Trade
    def my_send_child_order(product_code:, child_order_type:, side:, price: nil, size:,
      minute_to_expire: 43200, time_in_force: "GTC")

      body = "{
        'product_code': \"#{product_code}\",
        'child_order_type': \"#{child_order_type}\",
        'side': \"#{side}\",
        'price': #{price},
        'size': #{size},
        'minute_to_expire': #{minute_to_expire},
        'time_in_force': \"#{time_in_force}\"
      }"

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
          "{
            'product_code': \"#{product_code}\",
            'child_order_id': \"#{child_order_id}\"
          }"
        elsif child_order_acceptance_id
          "{
            'product_code': \"#{product_code}\",
            'child_order_acceptance_id': \"#{child_order_acceptance_id}\"
          }"
        end

      res = conn.post do |req|
        req.url "/v1/me/cancelchildorder"
        req.body = body
      end

      res.body
    end

    def my_cancel_all_child_orders(product_code:)
      body = "{
        'product_code': \"#{product_code}\"
      }"

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

    def my_send_parent_order(
      order_method:,
      minute_to_expire: 43200,
      time_in_force: "GTC",
      product_code:,
      first_condition_type:,
      first_side:,
      first_price: nil,
      first_size:,
      first_trigger_price: nil,
      first_offset: nil,
      second_condition_type:,
      second_price: nil,
      second_side:,
      second_size:,
      second_trigger_price: nil,
      second_offset: nil,
      third_condition_type: nil,
      third_side: nil,
      third_price: nil,
      third_size: nil,
      third_trigger_price: nil,
      third_offset: nil,
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
               'size': #{first_size},
               'price': #{first_price},
               'trigger_price': #{first_trigger_price},
               'offset': #{first_offset},
             },
             {
               'product_code': \"#{product_code}\",
               'condition_type': \"#{second_condition_type}\",
               'size': #{second_size},
               'side': \"#{second_side}\",
               'price': #{second_price},
               'trigger_price': #{second_trigger_price},
               'offset': #{second_offset},
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
               'size': #{first_size},
               'price': #{first_price},
               'trigger_price': #{first_trigger_price},
               'offset': #{first_offset},               
             },
             {
               'product_code': \"#{order_method}\",
               'condition_type': \"#{second_condition_type}\",
               'size': #{second_size},
               'side': \"#{second_side}\",
               'price': #{second_price},
               'trigger_price': #{second_trigger_price},
               'offset': #{second_offset},               
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
              'size': #{first_size},
              'price': #{first_price},
              'trigger_price': #{first_trigger_price},
              'offset': #{first_offset},                             
            },
            {
              'product_code': \"#{product_code}\",
              'condition_type': \"#{second_condition_type}\",
              'side': \"#{second_side}\",
              'size': #{second_size},
              'price': #{second_price},
              'trigger_price': #{second_trigger_price},
              'offset': #{second_offset},               
            },
            {
              'product_code': \"#{product_code}\",
              'condition_type': \"#{third_condition_type}\",
              'side': \"#{third_side}\",
              'size': #{third_size},
              'price': #{third_price},
              'trigger_price': #{third_trigger_price},
              'offset': #{third_offset},               
            }]
          }"
        else # SIMPLE
          "{
             'order_method': \"#{order_method}\",
             'minute_to_expire': #{minute_to_expire},
             'time_in_force': \"#{time_in_force}\",
             'parameters': [{
               'product_code': \"#{product_code}\",
               'condition_type': \"#{first_condition_type}\",
               'side': \"#{first_side}\",
               'size': #{second_size},
               'price': #{first_price},
               'trigger_price': #{first_trigger_price},
               'offset': #{first_offset},                             
             }]
          }"
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
        parent_order_state: parent_order_state
      )

      res = conn.get("/v1/me/getparentorders", query)
      res.body
    end

    def my_parent_order(parent_order_id: nil, parent_order_acceptance_id: nil)
      return unless parent_order_id || parent_order_acceptance_id

      query =
        if parent_order_id
          {parent_order_id: parent_order_id}
        else
          {parent_order_acceptance_id: parent_order_acceptance_id}
        end

      res = conn.get("/v1/me/getparentorder", query)
      res.body
    end

    def my_cancel_parent_order(product_code:, parent_order_id: nil, parent_order_acceptance_id: nil)
      return unless parent_order_id || parent_order_acceptance_id

      body =
        if parent_order_id
          "{
            'product_code': \"#{product_code}\",
            'parent_order_id': \"#{parent_order_id}\",
          }"
        elsif parent_order_acceptance_id
          "{
            'product_code': \"#{product_code}\",
            'parent_order_acceptance_id': \"#{parent_order_acceptance_id}\",
          }"
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
