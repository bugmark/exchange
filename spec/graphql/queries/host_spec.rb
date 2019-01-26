require "rails_helper"
require "rails_support"

RSpec.describe "GQL Host" do
  include_context "GraphQL"

  describe "base run" do
    it "runs ok" do
      expect(1).to eq(1)
    end
  end

  describe "GQL run" do
    let(:query_string) { "{ host { info { hostName } } }" }

    it "works" do
      expect(results).to_not be_nil
      expect(results.to_h).to be_a(Hash)
    end
  end
end
