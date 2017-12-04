require 'rails_helper'

describe "Contracts" do

  let(:user)     { FB.create(:user).user                  }
  let(:contract) { Contract.create                        }
  let(:taken)    { FB.create(:taken_contract)             }

  it "renders index" do
    visit "/core/contracts"
    expect(page).to_not be_nil
  end

  it "renders show" do
    visit "/core/contracts/#{contract.id}"
    expect(page).to_not be_nil
  end
end
