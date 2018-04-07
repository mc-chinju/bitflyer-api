module BitflyerApi
  module Methods
    module Public
      def market
        res = conn.get("/v1/markets")
        res.body
      end

      def board(product_code:)
        query = prepare_query(product_code: product_code)
        res = conn.get("/v1/board", query)
        res.body
      end

      def ticker(product_code:)
        query = prepare_query(product_code: product_code)
        res = conn.get("/v1/ticker", query)
        res.body
      end

      def executions(product_code:, count: 100, before: nil, after: nil)
        query = prepare_query(
          product_code: product_code,
          count: count,
          before: before,
          after: after,
        )

        res = conn.get("/v1/executions", query)
        res.body
      end

      def board_state(product_code:)
        query = prepare_query(product_code: product_code)
        res = conn.get("/v1/getboardstate", query)
        res.body
      end

      def health
        res = conn.get("/v1/gethealth")
        res.body
      end

      def chat(from_date: nil)
        query = prepare_query(from_date: from_date)

        res = conn.get("/v1/getchats", query)
        res.body
      end
    end
  end
end
