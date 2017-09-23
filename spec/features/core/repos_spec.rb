require 'rails_helper'

describe "Repos", USE_VCR do

  include_context 'Integration Environment'

  before(:each) { hydrate(repo1) }

  it "renders index" do
    visit "/core/repos"
    expect(page).to_not be_nil
  end

  it "renders show" do
    visit "/core/repos/#{repo1.id}"
    expect(page).to_not be_nil
  end
end
