require "rails_helper"
require "rails_support"

RSpec.describe "GQL User Mutation" do
  include_context "GraphQL"

  let(:user) { FB.create(:user).project.user }

  describe "User creation test with factory" do
    it "creates a user" do
      expect(User.count).to eq(0)
      hydrate(user)
      expect(User.count).to eq(1)
      expect(user.balance).to be_a(Float)
      expect(user.balance).to eq(1000.0)
    end
  end

  describe "User create with graphql" do
    let(:query_string) {
      'mutation { user_create(email: "bing@bang.com", password: "welcome") {id uuid email}}'
    }

    it "generates a user" do
      expect(User.count).to eq(0)
      expect(Event.count).to eq(0)
      expect(results).to_not be_nil
      expect(results.to_h).to be_a(Hash)
      expect(User.count).to eq(1)
      expect(Event.count).to eq(2)
    end
  end

  describe "deposit" do
    let(:query_string) {
      %Q[mutation {user_deposit(id: #{user.id}, amount: 10.0)}]
    }
    it "increases balance" do
      expect(results).to_not be_nil
      expect(User.first.balance).to eq(1010.0)
    end
  end

  describe "User withdraw" do
    let(:query_string) {
      %Q[mutation {user_withdraw(id: #{user.id}, amount: 10.0)}]
    }
    it "descreases balance" do
      expect(results).to_not be_nil
      expect(User.first.balance).to eq(990.0)
    end

  end
end
