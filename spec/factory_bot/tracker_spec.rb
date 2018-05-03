require 'rails_helper'

RSpec.describe 'Tracker GitHub Factory' do
  it "runs without params" do
    expect(Tracker.count).to eq(0)
    FB.create(:tracker)
    expect(Tracker.count).to eq(1)
  end
end
