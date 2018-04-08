require "spec_helper"

RSpec.describe "HTTP Private Api" do
  before do
    BitflyerApi.configure do |config|
      config.key    = "dummy_key"
      config.secret = "dummy_secret"
    end

    @client = BitflyerApi.client
  end

  it "GET my_balance" do
    VCR.use_cassette("get_my_balance") do
      response = @client.my_balance
      _response = response.first

      aggregate_failures do
        expect(_response["currency_code"]).to eq "JPY"
        expect(_response["amount"]).to be >= 0.0
        expect(_response["available"]).to be >= 0.0
      end
    end
  end

  it "GET my_collateral" do
    VCR.use_cassette("get_my_collateral") do
      response = @client.my_collateral

      aggregate_failures do
        expect(response["collateral"]).to be >= 0.0
        expect(response["open_position_pnl"]).to be >= 0.0
        expect(response["require_collateral"]).to be >= 0.0
        expect(response["keep_rate"]).to be >= 0.0
      end
    end
  end

  it "GET my_collateral_accounts" do
    VCR.use_cassette("get_my_collateral_accounts") do
      response = @client.my_collateral_accounts
      _response = response.first

      expect(_response["currency_code"]).to eq "JPY"
      expect(_response["amount"]).to be >= 0.0
    end
  end
end
