# require 'rails_helper'
#
# describe "User", USE_VCR do
#
#   let(:ask)  { FB.create(:offer_bf, user_uuid: user.uuid).offer }
#   let(:bid)  { FB.create(:offer_bu, user_uuid: user.uuid).offer }
#   let(:user) { FB.create(:user).user }
#
#   it "renders home" do
#     login_as user, :scope => :user
#
#     visit "/"
#     expect(page).to_not be_nil
#   end
#
#   it "renders /docfix/users/:id" do
#     login_as user, :scope => :user
#
#     visit "/docfix/users/#{user.id}"
#     expect(page).to_not be_nil
#   end
#
#   it "renders /docfix/users/:id with offers" do
#     hydrate(bid, ask)
#     login_as user, :scope => :user
#
#     visit "/docfix/users/#{user.id}"
#     expect(page).to_not be_nil
#   end
# end
