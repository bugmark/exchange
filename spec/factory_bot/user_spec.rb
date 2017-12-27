require 'rails_helper'

RSpec.describe 'User Factory' do

  it "runs without params" do
    expect(User.count).to eq(0)
    FB.create(:user)
    expect(User.count).to eq(1)
    expect(Event.count).to eq(2)
    expect(User.first.balance).to eq(1000.0)
  end
end
