require 'rails_helper'

RSpec.describe 'UserMembership Factory' do
  it "runs without params" do
    expect(User.count).to eq(0)
    expect(UserMembership.count).to eq(0)
    FB.create(:user_membership)
    expect(User.count).to eq(2)
    expect(UserMembership.count).to eq(1)
  end
end
