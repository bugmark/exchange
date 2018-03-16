require 'rails_helper'

RSpec.describe 'Issue GH Factory' do

  it "runs without params", USE_VCR do
    expect(Issue.count).to eq(0)
    FB.create(:gh_issue)
    expect(Issue.count).to eq(1)
  end
end
