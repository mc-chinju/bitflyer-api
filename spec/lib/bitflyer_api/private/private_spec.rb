require "spec_helper"

RSpec.describe "HTTP Public Api" do
  let!(:client){ BitflyerApi.client }

  it "Needs API_KEY and API_SECRET" do
    VCR.use_cassette("needs_access_key") do
      response = client.my_permissions

      aggregate_failures do
        expect(response["status"]).to eq -500
        expect(response["error_message"]).to eq "ACCESS-KEY header is required"
      end
    end
  end
end