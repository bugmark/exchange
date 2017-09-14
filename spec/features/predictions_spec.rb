require 'rails_helper'

describe "Predictions" do

  let(:user)     { FG.create(:user).user              }
  let(:contract) { Contract.create                    }
  let(:taken)    { FG.create(:taken_contract)         }

  it "renders index" do
    visit "/forecasts"
    expect(page).to_not be_nil
  end
end
