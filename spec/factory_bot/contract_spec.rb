require 'rails_helper'

RSpec.describe 'Contract Factory' do

  it "runs without params" do
    expect(Contract.count).to eq(0)
    expect(Event.count).to eq(0)
    FB.create(:contract)
    expect(Contract.count).to eq(1)
    expect(Event.count).to eq(1)
  end
end
