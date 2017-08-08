require 'rails_helper'

describe "Repos" do
  it "renders" do
    visit "/repos"
    expect(page).to_not be_nil
  end
end
