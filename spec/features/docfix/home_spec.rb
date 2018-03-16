require 'rails_helper'

describe "Home" do
  it "renders" do
    visit "/docfix/home"
    expect(page).to_not be_nil
  end
end
