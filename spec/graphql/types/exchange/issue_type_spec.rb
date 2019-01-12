require "rails_helper"

RSpec.describe "GraphQL Issue" do
  let(:context) { {} }
  let(:variables) { {} }
  let(:results) {
    res = BugmarkSchema.execute(
      query_string,
      context: context,
      variables: variables
    )
    pp res if res["errors"]
    res
  }

  describe "base run" do
    it "runs ok" do
      expect(1).to eq(1)
    end
  end

  describe "GraphQL run" do
    let(:query_string) { "{ issues { id } }" }

    it "works" do
      expect(results).to_not be_nil
      expect(results.to_h).to be_a(Hash)
    end
  end
end
