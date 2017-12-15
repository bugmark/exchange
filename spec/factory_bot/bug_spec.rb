require 'rails_helper'

RSpec.describe 'Bug Factory' do

  it "runs without params", USE_VCR do
    expect(Bug.count).to eq(0)
    FB.create(:bug)
    expect(Bug.count).to eq(1)
  end
end

#