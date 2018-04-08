require "spec_helper"

RSpec.describe "HTTP Public Api" do
  before do
    BitflyerApi.configure do |config|
      config.key    = "dummy_key"
      config.secret = "dummy_secret"
    end

    @client = BitflyerApi.client
  end

  fit "GET my_addresses" do
    VCR.use_cassette("get_my_addresses") do
      response = @client.my_addresses
      _response = response.first

      aggregate_failures do
        expect(_response["type"]).to eq "NORMAL"
        expect(_response["currency_code"]).to eq "BTC"
        expect(_response["address"]).not_to be_nil
      end
    end
  end

  # TODO: Create VCR cassette for test
  xit "GET my_coin_ins" do
    VCR.use_cassette("get_my_coin_ins") do
      response = @client.my_coin_ins
      _response = response.first

      expect(_response["id"]).not_to be_nil
    end
  end

  # TODO: Create VCR cassette for test
  xit "GET my_coin_outs" do
    VCR.use_cassette("get_my_coin_outs") do
      response = @client.my_coin_outs
      _response = response.first

      expect(_response["id"]).not_to be_nil
    end
  end

  # TODO: Create VCR cassette for test
  xit "GET my_bank_accounts" do
    VCR.use_cassette("get_my_bank_accounts") do
      response = @client.my_bank_accounts
      _response = response.first

      aggregate_failures do
        expect(_response["id"]).not_to be_nil
        expect(_response["is_verified"]).to be_truthy
        expect(_response["bank_name"]).not_to be_nil
        expect(_response["branch_name"]).not_to be_nil
        expect(_response["account_type"]).not_to be_nil
        expect(_response["account_number"]).not_to be_nil
        expect(_response["account_name"]).not_to be_nil
      end
    end
  end

  it "GET my_deposits" do
    VCR.use_cassette("get_my_deposits") do
      response = @client.my_deposits
      _response = response.first

      aggregate_failures do
        expect(_response["id"]).not_to be_nil
        expect(_response["order_id"]).not_to be_nil
        expect(_response["currency_code"]).to eq "JPY"
        expect(_response["amount"]).not_to be_nil
        expect(_response["status"]).to eq "COMPLETED"
        expect(_response["event_date"]).not_to be_nil
      end
    end
  end

  # TODO: Create VCR cassette for test
  xit "GET my_withdraw" do
    VCR.use_cassette("get_my_withdraw") do
      response = @client.my_withdraw(bank_account_id: 123456789, amount: 1000, code: 123456789)

      expect(response["message_id"]).to eq 123456789
    end
  end

  # TODO: Create VCR cassette for test
  xit "GET my_withdrawals" do
    VCR.use_cassette("get_my_withdrawals") do
      response = @client.my_withdrawals

      aggregate_failures do
        expect(response["id"]).not_to be_nil
        expect(response["order_id"]).not_to be_nil
        expect(response["currency_code"]).to eq "JPY"
        expect(response["amount"]).to be >= 0
        expect(response["atatus"]).to eq "COMPLETED"
        expect(response["event_date"]).not_to be_nil
      end
    end
  end
end
