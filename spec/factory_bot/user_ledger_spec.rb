require 'rails_helper'

RSpec.describe 'UserLedger Factory' do
  it "runs without params" do
    expect(User.count).to eq(0)
    expect(UserLedger.count).to eq(0)
    FB.create(:user_ledger)
    expect(User.count).to eq(1)
    expect(UserLedger.count).to eq(1)
  end
end
