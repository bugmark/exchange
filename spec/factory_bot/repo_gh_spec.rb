require 'rails_helper'

RSpec.describe 'GitHub Repo Factory' do

  it "runs without params", USE_VCR do
    expect(Repo.count).to eq(0)
    FB.create(:gh_repo)
    expect(Repo.count).to eq(1)
  end
end
#