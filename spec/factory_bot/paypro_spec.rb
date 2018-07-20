require 'rails_helper'

RSpec.describe 'Paypro Factory' do
  it "runs without params" do
    expect(Paypro.count).to eq(0)
    FB.create(:paypro)
    expect(Paypro.count).to eq(1)
  end
end
