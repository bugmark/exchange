require 'rails_helper'

RSpec.describe 'Contract Factory' do
  it "runs without params", USE_VCR do
    expect(Contract.count).to eq(0)
    FG.create(:base_contract)
    expect(Contract.count).to eq(1)
  end
end

