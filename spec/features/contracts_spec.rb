require 'rails_helper'

describe "Contracts" do

  let(:user)     { FG.create(:user).user              }
  let(:contract) { Contract.create                    }
  let(:taken)    { FG.create(:taken_contract)         }

  it "renders" do
    visit "/contracts"
    expect(page).to_not be_nil
  end
end
