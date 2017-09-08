require 'rails_helper'

describe "Asks" do

  let(:user)     { FG.create(:user).user              }
  let(:contract) { FG.create(:contract).contract      }
  let(:matured)  { FG.create(:matured_contract)       }
  let(:taken)    { FG.create(:taken_contract)         }
  let(:tak_mat)  { FG.create(:taken_matured_contract) }

  it "renders" do
    visit "/asks"
    expect(page).to_not be_nil
  end

  # it "renders /new" do
  #   login_as user, :scope => :user
  #
  #   visit "/asks/new"
  #   expect(page.body).to have_content("New Ask")
  # end
end
