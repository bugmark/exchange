require 'rails_helper'

describe "User", USE_VCR do

  let(:ask)  { FG.create(:buy_fixed, user_id: user.id).offer }
  let(:bid)  { FG.create(:buy_unfixed, user_id: user.id).offer }
  let(:user) { FG.create(:user).user }

  # it "renders home" do
  #   login_as user, :scope => :user
  #
  #   visit "/"
  #   expect(page).to_not be_nil
  # end
  #
  # it "renders /docfix/users/:id" do
  #   login_as user, :scope => :user
  #
  #   visit "/docfix/users/#{user.id}"
  #   expect(page).to_not be_nil
  # end
  #
  # it "renders /docfix/users/:id with offers" do
  #   hydrate(bid, ask)
  #   login_as user, :scope => :user
  #
  #   visit "/docfix/users/#{user.id}"
  #   expect(page).to_not be_nil
  # end
end
