require 'rails_helper'

RSpec.describe 'Repo GitHub Factory' do
  it "runs without params" do
    expect(Repo.count).to eq(0)
    FB.create(:repo)
    expect(Repo.count).to eq(1)
  end
end
