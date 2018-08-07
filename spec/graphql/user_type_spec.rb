require 'rails_helper'

RSpec.describe "GraphQL User" do
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

  describe "something simple" do
    it "runs ok" do
      expect(1).to eq(1)
    end
  end
end