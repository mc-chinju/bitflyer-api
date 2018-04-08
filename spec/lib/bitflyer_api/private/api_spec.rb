require "spec_helper"

RSpec.describe "HTTP Public Api" do
  before do
    BitflyerApi.configure do |config|
      config.key    = "dummy_key"
      config.secret = "dummy_secret"
    end

    @client = BitflyerApi.client
  end 

  it "GET my_permissions" do
    VCR.use_cassette("get_my_permissions") do
      response = @client.my_permissions

      expect(response.first).to eq "/v1/getmarkets" # representative sample
    end
  end
end
