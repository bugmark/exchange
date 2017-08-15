require 'rails_helper'

describe "Contracts" do

  let(:user)     { FG.create(:user).user              }
  let(:contract) { FG.create(:contract).contract      }
  let(:matured)  { FG.create(:matured_contract)       }
  let(:taken)    { FG.create(:taken_contract)         }
  let(:tak_mat)  { FG.create(:taken_matured_contract) }

  it "renders" do
    visit "/contracts"
    expect(page).to_not be_nil
  end

  it "takes an open contract" do
    login_as user, :scope => :user
    hydrate contract

    visit "/contracts"
    click_on "Take"
    click_on "Create Take"

    expect(page).to_not be_nil
  end

  it "resolves an open contract" do
    login_as user, :scope => :user
    hydrate matured

    visit "/contracts"
    click_on "Resolve"

    expect(page).to_not be_nil
  end

  it "resovles a taken contract" do
    login_as user, :scope => :user
    hydrate tak_mat

    visit "/contracts"
    click_on "Resolve"

    expect(page).to_not be_nil
  end
end
