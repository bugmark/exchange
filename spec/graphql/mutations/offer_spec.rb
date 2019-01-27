require "rails_helper"
require "rails_support"

RSpec.describe "GQL Offer Mutation" do
  include_context "GraphQL"

  let(:user) { FB.create(:user).project.user }

  describe "GraphQL run query" do
    let(:query_string) { "query { offers { id } }" }

    it "works" do
      expect(results).to_not be_nil
      expect(results.to_h).to be_a(Hash)
    end
  end
end
