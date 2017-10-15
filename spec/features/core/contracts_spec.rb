require 'rails_helper'

describe "Contracts" do

  let(:user)     { FG.create(:user).user                  }
  let(:contract) { Contract.create(price: 0.1, volume: 1) }
  let(:taken)    { FG.create(:taken_contract)             }

  it "renders index" do
    visit "/core/contracts"
    expect(page).to_not be_nil
  end

  it "renders show" do
    visit "/core/contracts/#{contract.id}"
    expect(page).to_not be_nil
  end
end
