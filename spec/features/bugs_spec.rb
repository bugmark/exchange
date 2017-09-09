require 'rails_helper'

describe "Bugs" do

  let(:user) { FG.create(:user).user }
  let(:bug)  { FG.create(:bug).bug   }

  it "renders" do
    visit "/bugs"
    expect(page).to_not be_nil
  end

  it "takes a bid" do
    login_as(user, :scope => :user)
    hydrate bug

    expect(Bid.count).to eq(0)

    visit "/bugs"
    click_on "Bid"
    click_on "Create Create"

    expect(Bid.count).to eq(1)
  end
end
