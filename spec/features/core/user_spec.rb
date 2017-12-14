require 'rails_helper'

describe "User", USE_VCR do

  let(:offer_bf) { FB.create(:offer_bf, user_id: user.id).offer }
  let(:offer_bu) { FB.create(:offer_bu, user_id: user.id).offer }
  let(:user)     { FB.create(:user).user }

  it "renders home" do
    login_as user, :scope => :user

    visit "/"
    expect(page).to_not be_nil
  end

  it "renders /core/users/:id" do
    login_as user, :scope => :user

    visit "/core/users/#{user.id}"
    expect(page).to_not be_nil
  end #.....

  # it "renders /core/users/:id with offers" do
  #   hydrate(offer_bf, offer_bu)
  #   login_as user, :scope => :user
  #
  #   visit "/core/users/#{user.id}"
  #   expect(page).to_not be_nil
  # end
end