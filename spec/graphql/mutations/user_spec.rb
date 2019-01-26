require "rails_helper"
require "rails_support"

RSpec.describe "GQL User Mutation" do
  include_context "GraphQL"

  describe "User creation" do
    let(:query_string) {
      'mutation { user_create(email: "bing@bang.com", password: "welcome")}'
    }

    it "generates a user" do
      expect(User.count).to eq(0)
      expect(Event.count).to eq(0)
      expect(results).to_not be_nil
      expect(results.to_h).to be_a(Hash)
      expect(User.count).to eq(1)
      expect(Event.count).to eq(1)
    end
  end
end
