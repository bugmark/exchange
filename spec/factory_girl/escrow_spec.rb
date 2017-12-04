require 'rails_helper'

RSpec.describe 'Escrow Factory' do
  it "runs without params" do
    expect(Escrow.count).to eq(0)
    FB.create(:escrow)
    expect(Escrow.count).to eq(1)
  end
end
