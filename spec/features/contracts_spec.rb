require 'rails_helper'

describe "Contracts" do
  it "renders" do
    visit "/contracts"
    expect(page).to_not be_nil
  end
end
