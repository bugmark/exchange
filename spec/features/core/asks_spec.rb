require 'rails_helper'

describe "Asks" do

  let(:user)     { FG.create(:user).user              }
  let(:ask)      { FG.create(:buy_ask).offer          }

  it "renders index" do
    visit "/core/asks"
    expect(page).to_not be_nil
  end
end