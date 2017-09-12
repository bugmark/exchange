require 'rails_helper'

describe "Offers" do

# TODO: Fixme

  let(:user)     { FG.create(:user).user              }
  let(:contract) { FG.create(:contract).contract      }
  let(:matured)  { FG.create(:matured_contract)       }
  let(:taken)    { FG.create(:taken_contract)         }
  let(:tak_mat)  { FG.create(:taken_matured_contract) }

  it "renders" do
    visit "/offers"
    expect(page).to_not be_nil
  end

end #.
