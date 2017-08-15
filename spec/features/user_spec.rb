require 'rails_helper'

describe "User" do
  it "renders" do
    user = FG.create(:user)
    login_as(user.user, :scope => :user)

    visit "/"
    expect(page).to_not be_nil
  end
end
