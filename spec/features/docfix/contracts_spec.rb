require 'rails_helper'

describe "Contracts" do

  let(:user)     { FG.create(:user).user                  }
  let(:contract) { Contract.create                        }
  let(:taken)    { FG.create(:taken_contract)             }

  it "renders index" do
    visit "/docfix/contracts"
    expect(page).to_not be_nil
  end

  it "renders show" do
    visit "/docfix/contracts/#{contract.id}"
    expect(page).to_not be_nil
  end
end
