require 'rails_helper'

describe "User" do

  let(:user) { FG.create(:user).user }

  it "renders home" do
    login_as user, :scope => :user

    visit "/"
    expect(page).to_not be_nil
  end

  it "renders /core/users/:id" do
    login_as user, :scope => :user

    visit "/core/users/#{user.id}"
    expect(page).to_not be_nil
  end
end #
