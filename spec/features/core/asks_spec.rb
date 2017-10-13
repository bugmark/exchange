# require 'rails_helper'
#
# describe "Asks" do
#
#   let(:user)     { FG.create(:user).user              }
#   let(:ask)      { FG.create(:ask).ask                }
#
#   it "renders index" do
#     visit "/core/asks"
#     expect(page).to_not be_nil
#   end
#
#   it "renders show", USE_VCR do
#     visit "/core/asks/#{ask.id}"
#     expect(page).to_not be_nil
#   end
#
#   it "renders new" do
#     login_as user, :scope => :user
#
#     visit "/core/asks/new"
#     expect(page.body).to have_content("New Ask")
#   end
# end
