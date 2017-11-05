require 'rails_helper'

describe "Bids" do

  let(:user)     { FG.create(:user).user                    }
  let(:bid)      { FG.create(:buy_unfixed).offer                }

  it "renders index" do
    visit "/core/bids"
    expect(page).to_not be_nil
  end
end
