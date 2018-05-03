require 'rails_helper'

describe "Trackers", USE_VCR do

  include_context 'Integration Environment'

  before(:each) { hydrate(tracker1) }

  it "renders index" do
    visit "/docfix/projects"
    expect(page).to_not be_nil
  end

  it "renders show" do
    visit "/docfix/projects/#{tracker1.id}"
    expect(page).to_not be_nil
  end
end
