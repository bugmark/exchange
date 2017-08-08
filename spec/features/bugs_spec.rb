require 'rails_helper'

describe "Bugs" do
  it "renders" do
    visit "/bugs"
    expect(page).to_not be_nil
  end
end
