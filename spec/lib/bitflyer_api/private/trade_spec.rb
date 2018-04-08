require "spec_helper"

RSpec.describe "HTTP Private Api" do
  before do
    BitflyerApi.configure do |config|
      config.key    = "dummy_key"
      config.secret = "dummy_secret"
    end

    @client = BitflyerApi.client
  end

  it "POST my_send_child_order" do
    VCR.use_cassette("post_my_send_child_order") do
      response = @client.my_send_child_order(
        product_code: "FX_BTC_JPY",
        child_order_type: "LIMIT",
        side: "BUY",
        price: 1000000,
        size: 0.01,
      )

      expect(response["child_order_acceptance_id"]).not_to be_nil
    end
  end

  it "POST my_cancel_child_order" do
    VCR.use_cassette("post_my_cancel_child_order") do
      response = @client.my_cancel_child_order(
        product_code: "FX_BTC_JPY",
        child_order_id: "JFX20180101-123456-123456F",
      )

      expect(response).to be_nil
    end
  end

  it "POST my_cancel_all_child_orders" do
    VCR.use_cassette("post_my_cancel_all_child_orders") do
      response = @client.my_cancel_all_child_orders(product_code: "FX_BTC_JPY")

      expect(response).to be_nil
    end
  end

  it "GET my_child_orders" do
    VCR.use_cassette("get_my_child_orders") do
      response = @client.my_child_orders(product_code: "FX_BTC_JPY")
      _response = response.first

      aggregate_failures do
        expect(_response["id"]).not_to be_nil
        expect(_response["child_order_id"]).not_to be_nil
      end
    end
  end

  context "POST my_send_parent_order" do
    it "IFD order" do
      VCR.use_cassette("post_my_send_parent_order_ifd") do
        response = @client.my_send_parent_order(
          order_method: "IFD",
          product_code: "FX_BTC_JPY",
          first_condition_type: "LIMIT",
          first_side: "BUY",
          first_price: 500000,
          first_size: 0.01,
          second_condition_type: "LIMIT",
          second_side: "SELL",
          second_price: 900000,
          second_size: 0.01,
        )

        expect(response["parent_order_acceptance_id"]).not_to be_nil
      end
    end

    it "OCO order" do
      VCR.use_cassette("post_my_send_parent_order_oco") do
        response = @client.my_send_parent_order(
          order_method: "OCO",
          product_code: "FX_BTC_JPY",
          first_condition_type: "LIMIT",
          first_side: "BUY",
          first_price: 500000,
          first_size: 0.01,
          second_condition_type: "LIMIT",
          second_side: "SELL",
          second_price: 900000,
          second_size: 0.01,
        )

        expect(response["parent_order_acceptance_id"]).not_to be_nil
      end
    end

    it "IFDOCO order" do
      VCR.use_cassette("post_my_send_parent_order_ifdoco") do
        response = @client.my_send_parent_order(
          order_method: "IFDOCO",
          product_code: "FX_BTC_JPY",
          first_condition_type: "LIMIT",
          first_side: "BUY",
          first_price: 600000,
          first_size: 0.01,
          second_condition_type: "LIMIT",
          second_side: "SELL",
          second_price: 700000,
          second_size: 0.01,
          third_condition_type: "LIMIT",
          third_side: "SELL",
          third_price: 550000,
          third_size: 0.01,
        )

        expect(response["parent_order_acceptance_id"]).not_to be_nil
      end
    end
  end

  it "GET my_parent_orders" do
    VCR.use_cassette("get_my_parent_orders") do
      response = @client.my_parent_orders(
        product_code: "FX_BTC_JPY",
        parent_order_state: "ACTIVE",
      )
      _response = response.first

      aggregate_failures do
        expect(_response["id"]).not_to be_nil
        expect(_response["side"]).to eq "BUYSELL"
        expect(_response["parent_order_type"]).to eq "IFD"
      end
    end
  end

  it "GET my_parent_order" do
    VCR.use_cassette("get_my_parent_order") do
      response = @client.my_parent_order(
        parent_order_id: "JCP20180409-034250-245215",
      )

      aggregate_failures do
        expect(response["id"]).not_to be_nil
        expect(response["parent_order_id"]).not_to be_nil
        expect(response["order_method"]).not_to be_nil
      end
    end
  end

  it "POST my_cancel_parent_order" do
    VCR.use_cassette("post_my_cancel_parent_order") do
      response = @client.my_cancel_parent_order(
        product_code: "FX_BTC_JPY",
        parent_order_id: "JCP20180409-034250-245215",
      )

      expect(response).to be_nil
    end
  end

  it "GET my_executions" do
    VCR.use_cassette("get_my_executions") do
      response = @client.my_executions(
        product_code: "FX_BTC_JPY",
        count: 3,
      )
      _response = response.first

      expect(_response["id"]).not_to be_nil
    end
  end

  it "GET my_positions" do
    VCR.use_cassette("get_my_positions") do
      response = @client.my_positions(product_code: "FX_BTC_JPY")
      _response = response.first

      expect(_response["size"]).to be >= 0
    end
  end

  it "GET my_collateral_history" do
    VCR.use_cassette("get_my_collateral_history") do
      response = @client.my_collateral_history(count: 1)
      _response = response.first

      expect(_response["id"]).not_to be_nil
    end
  end

  it "GET my_trading_commission" do
    VCR.use_cassette("get_my_trading_commission") do
      response = @client.my_trading_commission(product_code: "FX_BTC_JPY")

      expect(response["commission_rate"]).to be >= 0
    end
  end
end
