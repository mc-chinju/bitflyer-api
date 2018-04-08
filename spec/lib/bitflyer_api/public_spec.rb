require "spec_helper"

RSpec.describe "HTTP Public Api" do
  let!(:client){ BitflyerApi.client }

  it "GET market" do
    VCR.use_cassette("get_markets") do
      response = client.market

      expect(response.second["product_code"]).to eq("FX_BTC_JPY")
    end
  end

  it "GET board" do
    VCR.use_cassette("get_board") do
      response = client.board(product_code: "FX_BTC_JPY")

      expect(response.has_key?("mid_price")).to be_truthy
    end
  end

  it "GET ticker" do
    VCR.use_cassette("get_ticker") do
      response = client.ticker(product_code: "FX_BTC_JPY")

      expect(response["product_code"]).to eq("FX_BTC_JPY")
    end
  end

  it "GET executions" do
    VCR.use_cassette("get_executions") do
      response = client.executions(product_code: "FX_BTC_JPY")

      aggregate_failures do
        expect(response.first["id"]).not_to be_nil
        expect(response.first["side"]).to eq("BUY").or eq("SELL")
      end
    end
  end

  it "GET board_state" do
    VCR.use_cassette("get_board_state") do
      response = client.board_state(product_code: "FX_BTC_JPY")

      aggregate_failures do
        expect(response["health"]).to eq("BUSY")
        expect(response["state"]).to eq("BUY").or eq("RUNNING")
      end
    end
  end

  it "GET health" do
    VCR.use_cassette("get_health") do
      response = client.health

      expect(response.has_key?("status")).to be_truthy
    end
  end

  xit "GET chat" do
    # Raised error when the test used cassette
    response = client.chat

    expect(response.first.has_key?("nickname")).to be_truthy
  end
end
