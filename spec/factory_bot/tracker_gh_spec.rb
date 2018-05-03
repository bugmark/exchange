require 'rails_helper'

RSpec.describe 'GitHub Tracker Factory' do

  it "runs without params", USE_VCR do
    expect(Tracker.count).to eq(0)
    FB.create(:gh_tracker)
    expect(Tracker.count).to eq(1)
  end
end
